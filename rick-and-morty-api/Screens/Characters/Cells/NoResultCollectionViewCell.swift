//
//  NoResultCollectionViewCell.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 31/08/2023.
//

import SnapKit
import UIKit

class NoResultCollectionViewCell: UICollectionViewCell {
    // MARK: - Variables

    static let reuseIdentifier: String = "NoResultCollectionViewCell"
    
    private let mainView = UIView()
    private let noResultLabel = UILabel()
   
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        noResultLabel.adjustsFontSizeToFitWidth = true
        noResultLabel.textColor = UIColor(named: "textColor")
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Error initializing cell.")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Functions

    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        noResultLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(noResultLabel)
    }
    
    func configure(with text: String) {
        noResultLabel.text = text
    }
}
