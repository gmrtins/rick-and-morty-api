//
//  Network.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 25/08/2023.
//

import Foundation

class RickAndMortyAPIService {
    private var dataCache: [Int: Character] = [:]
    var characters = [Character]()

    typealias FetchCompletion = (Result<[Character], Error>) -> Void

    // MARK: - Public API

    func fetchData(completion: @escaping FetchCompletion) {
        guard let baseUrl = URL(string: "https://rickandmortyapi.com/api/character") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: baseUrl) { [weak self] data, _, error in
            if let data = data {
                do {
                    let apiResponse = try JSONDecoder().decode(RickAndMortyAPIResponse.self, from: data)

                    // Fetch all characters across all pages
                    self?.fetchCharacters(for: apiResponse.info.pages) {
                        completion($0)
                    }
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }

    // MARK: - Private Methods

    private func fetchCharacters(for totalPages: Int, completion: @escaping FetchCompletion) {
        let dispatchGroup = DispatchGroup()

        for page in 1 ... totalPages {
            guard let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)") else {
                completion(.failure(NetworkError.invalidURL))
                return
            }

            dispatchGroup.enter()
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                defer { dispatchGroup.leave() }

                if let data = data {
                    do {
                        let model = try JSONDecoder().decode(RickAndMortyAPIResponse.self, from: data)
                        self?.characters.append(contentsOf: model.results)
                    } catch {
                        completion(.failure(error))
                    }
                } else if let error = error {
                    completion(.failure(error))
                }
            }.resume()
        }

        dispatchGroup.notify(queue: .main) {
            completion(.success(self.characters))
        }
    }
}

// MARK: - Extensions

extension Int: Sequence {
    public func makeIterator() -> CountableRange<Int>.Iterator {
        return (0 ..< self).makeIterator()
    }
}

// MARK: - Enums

enum NetworkError: Error {
    case invalidURL
}
