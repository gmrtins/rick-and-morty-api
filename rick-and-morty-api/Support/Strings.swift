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
            static let about = "About"
            static let characters = "Characters"
        }
    }

    enum AboutView {
        static let nameLabel = "Gonçalo Martins"
        static let iconURL = "https://avatars.githubusercontent.com/u/49563508?v=4"
        static let descriptionLabel = "Hi, my name is Gonçalo Martins, I'm an iOS developer from Coimbra, Portugal. If you want to know a litle bit more about me and the projects I've worked on, you can click the link bellow"
        static let readmeTitle = "Project README"
        static let readmeURL = "https://github.com/gmrtins/rick-and-morty-api#readme"
        static let linktreeTitle = "Get to know me!"
        static let linktreeURL = "https://linktr.ee/goncalomartins.dev"
    }

    enum CharactersView {
        static let titleLabel = "What Rick and Morty caracter are you looking for ?"
        static let searchBarPlaceholder = "e.g Pickle Rick"
        static let noResultsText = "No results"
    }

    enum CharacterView {
        static let episodesLabel = "Episodes"
    }
}
