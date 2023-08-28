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
    
    private let apiService = RickAndMortyAPIService()
    var filteredData: [Character] = []
    var onDataUpdated: (() -> Void)?
    
    var characters: [Character] = [] {
        didSet {
            onDataUpdated?()
        }
    }
    
    // MARK: - Functions
    
    func fetchData() {
        apiService.fetchData { result in
            switch result {
            case .success(let characters):
                self.characters = characters
                self.filteredData = characters
            case .failure(let error):
                print("Error fetching data:", error)
            }
        }
    }
}
