//
//  Requests.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 01/09/2023.
//

import Foundation

protocol APIProtocol {
    var baseURL: URL { get }
    var charactersPath: String { get }
    
    func characters(page: Int?, name: String?) -> URL
    func searchCharacters(name: String) -> URL
    func characterDetail(id: Int) -> URL
}

struct API: APIProtocol {
    let baseURL = URL(string: "https://rickandmortyapi.com/")!
    let charactersPath = "api/character"
    let episodesPath = "api/episode"
    
    func characters(page: Int?, name: String?) -> URL {
        var urlComponents = baseURL.appendingPathComponent(charactersPath)
        urlComponents.append(queryItems: [URLQueryItem(name: "page", value: String(page ?? 1)), URLQueryItem(name: "name", value: name)])
        
        return urlComponents
    }
    
    func searchCharacters(name: String) -> URL {
        var urlComponents = baseURL.appendingPathComponent(charactersPath)
        urlComponents.append(queryItems: [URLQueryItem(name: "name", value: name)])
        
        return urlComponents
    }
    
    func characterDetail(id: Int) -> URL {
        return baseURL.appendingPathComponent("\(charactersPath)/\(id)")
    }
    
    func episodes(ids: String) -> URL {
        return baseURL.appendingPathComponent("\(episodesPath)/\(ids)")
    }
}
