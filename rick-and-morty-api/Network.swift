//
//  Network.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 25/08/2023.
//

import Foundation

class RickAndMortyAPIService {
    private var dataCache: [Int: Character] = [:]
    var pages = 0
    var characters = [Character]()
    
    func fetchData(completion: @escaping (Result<[Character], Error>) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let apiResponse = try JSONDecoder().decode(RickAndMortyAPIResponse.self, from: data)
                    self.pages = apiResponse.info.pages
                    // Cache the characters
                    
                    for page in 1 ... apiResponse.info.pages {
                        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)") else {
                            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
                            return
                        }
                        
                        URLSession.shared.dataTask(with: url) { data, _, error in
                            if let data = data {
                                do {
                                    let model = try JSONDecoder().decode(RickAndMortyAPIResponse.self, from: data)
                                    
                                    model.results.forEach { character in
                                        self.characters.append(character)
                                    }
                                    
                                    completion(.success(self.characters))
                                } catch {
                                    completion(.failure(error))
                                }
                            } else if let error = error {
                                completion(.failure(error))
                            }
                        }.resume()
                    }
                    
                    self.characters.forEach { c in
                        self.dataCache[c.id] = c
                    }
                    completion(.success(apiResponse.results))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}

extension Int: Sequence {
    public func makeIterator() -> CountableRange<Int>.Iterator {
        return (0 ..< self).makeIterator()
    }
}
