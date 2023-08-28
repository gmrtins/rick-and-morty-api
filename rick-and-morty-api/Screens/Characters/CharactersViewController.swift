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
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    //    private let apiService = RickAndMortyAPIService()
    //    private var characters: [Character] = []
    var viewModel: CharactersViewModel

    // MARK: - Initialization
    
    required init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        setupView()
        setupCollectionView()
        setupConstraints()
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        viewModel.fetchData()
        
        //        apiService.fetchData { result in
        //               switch result {
        //               case .success(let characters):
        //                   self.characters = characters
        //                   DispatchQueue.main.async {
        //                       self.collectionView.reloadData()
        ////
        //                   }
        //               case .failure(let error):
        //                   print("Error fetching data:", error)
        //               }
        //           }
    }
    
    func setupView() {
        view.addSubview(mainView)
        
        view.backgroundColor = .systemBackground
        
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
            make.top.equalToSuperview().inset(50)
            make.left.right.equalToSuperview().inset(15)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(10)
        }
    }
    
    func setupCollectionView() {
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
    }
}

// MARK: - CollectionView Delegates

extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return characters.count
        viewModel.filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
        
        //        let j = Character(id: 1, name: "Johnnnnn Ceeena", status: "Dead", species: "ASD", type: "ASD", gender: "ASD", origin: .init(name: "as", url: "asd"), location: .init(name: "adasd", url: "asdas"), image: "", episode: ["1","2"], url: "asd", created: "asd")
        //
        let character = viewModel.filteredData[indexPath.item]
        cell.configure(with: character)
        return cell
        //        cell.set(with: j)
        //        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let cellWidth = collectionViewWidth / 2 - 5 // You can adjust the insets
        
        // Use your custom logic to calculate the height if needed
        let cellHeight: CGFloat = 120
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = viewModel.filteredData[indexPath.row]
        //
        let characterVC = CharacterViewController(character: selected)
        //
        //        navigationController?.show(characterVC, sender: nil)
        navigationController?.pushViewController(characterVC, animated: true)
    }
}

// MARK: - SearchBar Delegates

extension CharactersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.filteredData = viewModel.characters
        } else {
            viewModel.filteredData = viewModel.characters.filter { item in
                item.name.lowercased().contains(searchText.lowercased()) // Adjust this condition according to your data structure
            }
        }
        
        collectionView.reloadData()
    }
}
