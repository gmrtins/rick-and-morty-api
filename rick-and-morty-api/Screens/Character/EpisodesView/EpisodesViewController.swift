//
//  EpisodesViewController.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 01/09/2023.
//

import Foundation
import SnapKit
import UIKit

class EpisodesViewController: UIViewController, UITableViewDelegate {
    // MARK: - UI Elements
    
    private let mainView = UIView()
    private let tableView = UITableView()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()

    // MARK: - Variables

    private var episodes: [String]
    private let viewModel = EpisodesViewModel()

    // MARK: - Functons
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        print("type \(type(of: episodes))")
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.loadingIndicator.stopAnimating()
                self?.setupTableView()
            }
        }
        loadingIndicator.startAnimating()

        Task {
            await viewModel.fetchData(episodes)
        }
    }
    
    private func setupView() {
        view.addSubview(mainView)
        mainView.backgroundColor = Colors.backgroundColor.color
        mainView.addSubview(tableView)
        mainView.addSubview(loadingIndicator)
    }
    
    private func setupTableView() {
        tableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate.self
        tableView.backgroundColor = Colors.backgroundColor.color
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(episodes: [String]) {
        self.episodes = episodes
        super.init(nibName: nil, bundle: nil)
    }
}

// MARK: - TableView Delegates

extension EpisodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.reuseIdentifier, for: indexPath) as! EpisodeTableViewCell
        
        cell.configure(with: viewModel.filteredData[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
