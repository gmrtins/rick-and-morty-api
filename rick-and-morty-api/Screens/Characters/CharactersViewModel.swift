//
//  CharactersViewModel.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 25/08/2023.
//

import Foundation
import Combine

class CharactersViewModel {
    private let apiService = RickAndMortyAPIService()
    //     var characters: [Character] = []
    
    var onDataUpdated: (() -> Void)?
    var characters: [Character] = [] {
        didSet {
            onDataUpdated?()
        }
    }
    var filteredData: [Character] = []

    func fetchData() {
        apiService.fetchData { result in
            switch result {
            case .success(let characters):
                self.characters = characters
                self.filteredData = characters
            case .failure(let error):
                print("Error fetching data:", error)
            }
        }    }
}
