//
//  CharacterCollectionViewCell.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 24/08/2023.
//

import SnapKit
import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier: String = "CharacterCollectionViewCell"
    let nameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error initializing cell.")
    }
    
    func addSubviews() {
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func set(with character: String) {
        nameLabel.text = character
    }
}
