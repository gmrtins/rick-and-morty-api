//
//  NetworkManager.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 30/08/2023.
//

import Combine
import Foundation

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    private var cancellables: Set<AnyCancellable> = []

    private init() {}

    func request<T: Decodable>(
        url: URL,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      200 ..< 300 ~= httpResponse.statusCode
                else {
                    throw NetworkError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    debugPrint(error)
                }
            } receiveValue: { response in
                completion(.success(response))
            }
            .store(in: &cancellables)
    }

    func cancelRequests() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}

enum NetworkError: Error {
    case invalidResponse
    case noData
    case other(Error)
}
