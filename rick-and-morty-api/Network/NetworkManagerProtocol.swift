//
//  NetworkManagerProtocol.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 01/09/2023.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    func request<T: Decodable>(
        url: URL,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
    
    func cancelRequests()
}
