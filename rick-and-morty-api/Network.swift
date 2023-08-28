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
    var cenas = [Character]()

//    func fetchPageNumbers(completion: @escaping (Result<RickAndMortyAPIResponse, Error>) -> Void) {
//        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
//            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let data = data {
//                do {
//                    let apiResponse = try JSONDecoder().decode(RickAndMortyAPIResponse.self, from: data)
//                    self.total = apiResponse.info.pages
//                    completion(.success(apiResponse))
//
//                } catch {
//                    completion(.failure(error))
//                }
//            } else if let error = error {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
//
//    func fetchData(completion: @escaping (Result<[Character], Error>) -> Void) {
    //        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
    //            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
    //            return
    //        }
    //
    //        URLSession.shared.dataTask(with: url) { (data, response, error) in
    //            if let data = data {
    //                do {
    //                    let apiResponse = try JSONDecoder().decode(RickAndMortyAPIResponse.self, from: data)
    //                    self.total = apiResponse.info.pages
    //                    // Cache the characters
    //                    apiResponse.results.forEach { character in
    //                        self.dataCache[character.id] = character
    //                    }
    //
    //                    completion(.success(apiResponse.results))
    //                } catch {
    //                    completion(.failure(error))
    //                }
    //            } else if let error = error {
    //                completion(.failure(error))
    //            }
    //        }.resume()
    //    }
    //
        
    func fetchData(completion: @escaping (Result<[Character], Error>) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
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
                        
                        URLSession.shared.dataTask(with: url) { (data, response, error) in
                                    if let data = data {
                                        do {
                                            let model = try JSONDecoder().decode(RickAndMortyAPIResponse.self, from: data)
                                         
                                            // Cache the characters
                                            model.results.forEach { character in
                                                self.cenas.append(character)
//                                                self.dataCache[character.id] = character
                                            }
                        
                                            completion(.success(self.cenas))
                                        } catch {
                                            completion(.failure(error))
                                        }
                                    } else if let error = error {
                                        completion(.failure(error))
                                    }
                                }.resume()
                        
                    }
                    
                    self.cenas.forEach { c in
                        self.dataCache[c.id] = c
                        print(c)

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
        return (0..<self).makeIterator()
    }
}
