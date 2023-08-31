//
//  CharactersViewModel.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 25/08/2023.
//

import Combine
import Foundation

class CharactersViewModel {
    // MARK: - Variables
    
    //    private let apiService = RickAndMortyAPIService()
    var filteredData: [Character] = []
    var onDataUpdated: (() -> Void)?
    
    var characters: [Character] = [] {
        didSet {
            onDataUpdated?()
        }
    }
    
    var totalPages = 1
    var currentPage = 1
    var keepLoading = true
    var queryName = ""
    
    // MARK: - Functions
    
    func fetchData() async {
        if keepLoading {
            let url = API.characters(page: currentPage, name: queryName)
            
            NetworkManager.shared.request(url: url, responseType: RickAndMortyAPIResponse.self) { result in
                switch result {
                case .success(let response):
                    self.totalPages = response.info.pages
                    
                    self.characters.append(contentsOf: response.results)
                    self.filteredData = self.characters
                    
                case .failure(let error):
                    // Handle the error
                    switch error {
                    case .invalidResponse:
                        print("Invalid response")
                    case .noData:
                        print("No data received")
                    case .other(let underlyingError):
                        print("Other error: \(underlyingError)")
                    }
                }
                if self.currentPage != self.totalPages {
                    self.currentPage += 1
                } else {
                    self.keepLoading = false
                }
            }
        }
    }
    
    func search(_ name: String) async {
        currentPage = 1
        keepLoading = true
        characters.removeAll()
        filteredData.removeAll()
        
        queryName = name
        await fetchData()
    }
    
    func resetSearch() {
        totalPages = 1
        currentPage = 1
        keepLoading = true
        queryName = ""
        characters.removeAll()
        filteredData.removeAll()
    }
}
