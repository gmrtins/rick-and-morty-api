//
//  Strings.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 30/08/2023.
//

import Foundation

struct Strings {
    enum MainView {
        enum TabBarTitles {
            static let about = NSLocalizedString("mainViewTabBarAboutTabTitle", comment: "Localizable")
            static let characters = NSLocalizedString("mainViewTabBarCharactersTabTitle", comment: "Localizable")
        }
    }
    
    enum AboutView {
        static let nameLabel = NSLocalizedString("aboutViewNameLabel", comment: "Localizable")
        static let iconURL = "https://avatars.githubusercontent.com/u/49563508?v=4"
        static let descriptionLabel = NSLocalizedString("aboutViewDescriptionLabel", comment: "Localizable")
        static let readmeTitle = NSLocalizedString("aboutViewReadmeTitle", comment: "Localizable")
        static let readmeURL = "https://github.com/gmrtins/rick-and-morty-api#readme"
        static let linktreeTitle = NSLocalizedString("aboutViewLinktreeTitle", comment: "Localizable")
        static let linktreeURL = "https://linktr.ee/goncalomartins.dev"
    }
    
    enum CharactersView {
        static let titleLabel = NSLocalizedString("charactersViewTitle", comment: "Localizable")
        static let searchBarPlaceholder = NSLocalizedString("charactersViewSearchBarPlaceholder", comment: "Localizable")
        static let noResultsText = NSLocalizedString("noResultsText", comment: "Localizable")
    }
    
    enum CharacterView {
        static let episodeLabel = NSLocalizedString("characterViewEpisodeLabel", comment: "Localizable")
        static let episodesLabel = NSLocalizedString("characterViewEpisodesLabel", comment: "Localizable")
        static let maleText = NSLocalizedString("male_gender_text", comment: "Localizable")
        static let femaleText = NSLocalizedString("female_gender_text", comment: "Localizable")
        static let genderlessText = NSLocalizedString("genderless_gender_text", comment: "Localizable")
        static let unknown = NSLocalizedString("unknown", comment: "Localizable")
        static let alive = NSLocalizedString("alive", comment: "Localizable")
        static let dead = NSLocalizedString("dead", comment: "Localizable")
    }
}
