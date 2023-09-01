//
//  EpisodesViewModel.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 01/09/2023.
//

import Combine
import Foundation

class EpisodesViewModel {
    // MARK: - Variables

    var onDataUpdated: (() -> Void)?

    var filteredData: [EpisodeElement] = [] {
        didSet {
            onDataUpdated?()
        }
    }

    // MARK: - Functions

    func fetchData(_ episodes: [String]) async {
        var numbers: [String] = []

        for urlString in episodes {
            if let lastComponent = urlString.components(separatedBy: "/").last,
               let episodeNumber = Int(lastComponent)
            {
                numbers.append("\(episodeNumber)")
            }
        }
        let formatedIds = numbers.joined(separator: ",")

        let episodesURL = API().episodes(ids: formatedIds)

        if episodes.count > 1 {
            NetworkManager.shared.request(url: episodesURL, responseType: [EpisodeElement].self) { result in
                switch result {
                case .success(let episodes):
                    for episode in episodes {
                        self.filteredData.append(episode)
                    }
                case .failure(let error):
                    switch error {
                    case .invalidResponse:
                        print("Invalid response")
                    case .noData:
                        print("No data received")
                    case .other(let underlyingError):
                        print("Other error: \(underlyingError)")
                    }
                }
            }
        } else {
            NetworkManager.shared.request(url: episodesURL, responseType: EpisodeElement.self) { result in
                switch result {
                case .success(let episode):
                    self.filteredData.append(episode)
                case .failure(let error):
                    switch error {
                    case .invalidResponse:
                        print("Invalid response")
                    case .noData:
                        print("No data received")
                    case .other(let underlyingError):
                        print("Other error: \(underlyingError)")
                    }
                }
            }
        }
    }
}
