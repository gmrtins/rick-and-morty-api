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
    
    private let mainView = UIView()
    private let titleLabel = UILabel()
    private let searchBar = UISearchBar()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - Variables
    
    private let viewModel: CharactersViewModel
    private let strings = Strings.CharactersView.self
    private var searchTask: DispatchWorkItem?
    
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
        setupConstraints()
        
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.loadingIndicator.stopAnimating()
                self?.setupCollectionView()
            }
        }
        loadingIndicator.startAnimating()
        
        Task {
            await viewModel.fetchData()
        }
    }
    
    // MARK: - Functions
    
    func setupView() {
        view.addSubview(mainView)
        
        view.backgroundColor = .systemBackground
        
        titleLabel.text = strings.titleLabel
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.numberOfLines = 2
        
        mainView.addSubview(loadingIndicator)
        
        mainView.addSubview(titleLabel)
        mainView.addSubview(searchBar)
        
        searchBar.placeholder = strings.searchBarPlaceholder
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
        
        loadingIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        viewModel.filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
        
        let character = viewModel.filteredData[indexPath.item]
        cell.configure(with: character)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let cellWidth = collectionViewWidth / 2 - 5
        
        let cellHeight: CGFloat = 120
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = viewModel.filteredData[indexPath.row]
        let characterVC = CharacterViewController(character: selected)
        
        navigationController?.pushViewController(characterVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let collectionViewContentSizeHeight = collectionView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        if position > (collectionViewContentSizeHeight - 120 - scrollViewHeight) {
            Task {
                await viewModel.fetchData()
            }
        }
    }
}

// MARK: - SearchBar Delegates

extension CharactersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTask?.cancel()
        
        let task = DispatchWorkItem { [weak self] in
            if searchText.isEmpty {
                self?.viewModel.resetSearch()
                Task {
                    await self?.viewModel.fetchData()
                }
            } else {
                Task {
                    await self?.viewModel.search(searchText.lowercased())
                }
            }
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        searchTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task)
    }
}
