//
//  EpisodeTableViewCell.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 01/09/2023.
//

import SnapKit
import UIKit

class EpisodeTableViewCell: UITableViewCell {
    // MARK: - Variables

    static let reuseIdentifier: String = "EpisodeTableViewCell"
    
    // MARK: - UI Elements

    private let episodeNameLabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Colors.textColor.color
        return label
    }()
    
    private let airDateLabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Colors.textColor.color
        return label
    }()
    
    private let episodeNumberLabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Colors.textColor.color
        return label
    }()
    
    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func setupView() {
        contentView.backgroundColor = Colors.backgroundColor.color
        contentView.addSubview(episodeNameLabel)
        contentView.addSubview(episodeNumberLabel)
        contentView.addSubview(airDateLabel)
    }
    
    private func setupConstraints() {
        episodeNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        episodeNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(episodeNameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        airDateLabel.snp.makeConstraints { make in
            make.top.equalTo(episodeNumberLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configure(with episode: EpisodeElement) {
        episodeNameLabel.text = episode.name
        airDateLabel.text = episode.airDate
        episodeNumberLabel.text = episode.episode
    }
}
