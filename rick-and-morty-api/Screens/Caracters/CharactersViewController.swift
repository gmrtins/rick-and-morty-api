//
//  CharactersViewController.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 24/08/2023.
//

import Foundation
import SnapKit
import UIKit

class CharactersViewController: UIViewController, UICollectionViewDelegate {
    // MARK: - UI Elements
    
    let mainView = UIView()
    let titleLabel = UILabel()
    var searchBar = UISearchBar()
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        setupConstraints()
    }
    
    func setupView() {
        view.addSubview(mainView)
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        titleLabel.text = "What Rick and Morty caracter are you looking for ?"
        //        titleLabel.font = .systemFont(ofSize: 25)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = .boldSystemFont(ofSize: 25)
        //        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        titleLabel.numberOfLines = 2
        //        mainView.backgroundColor = .white
        mainView.addSubview(titleLabel)
        mainView.addSubview(searchBar)
        
        searchBar.placeholder = "e.g Pickle Rick"
        searchBar.searchBarStyle = .minimal
    }
    
    func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.left.right.equalToSuperview().inset(15)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(10)
        }
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(30)
            make.left.right.bottom.equalToSuperview().inset(10)
        }
    }
}

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 150 // Adjust the number of items as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
        cell.backgroundColor = .blue
        cell.set(with: "x")
        return cell
    }
}
