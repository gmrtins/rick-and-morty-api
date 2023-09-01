//
//  CharacterCollectionViewCell.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 24/08/2023.
//

import SDWebImage
import SnapKit
import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    // MARK: - Variables

    static let reuseIdentifier: String = "CharacterCollectionViewCell"
    
    // MARK: - UI Elements

    private let mainView = UIView()
    private let nameLabel = UILabel()
    private let imageView = UIImageView()
    private let opacityLayer = UIView()
    private let genderLabel = UILabel()
    private let statusLabel = UILabel()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textColor = .white
        genderLabel.textColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Error initializing cell.")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        opacityLayer.alpha = 0.5
        opacityLayer.backgroundColor = .black
    }
    
    // MARK: - Functions

    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        opacityLayer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        statusLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.right.equalTo(statusLabel.snp.left).offset(-5)
            make.centerY.equalTo(statusLabel.snp.centerY)
        }
    }
    
    private func addSubviews() {
        contentView.addSubview(mainView)
        
        mainView.addSubview(imageView)
        mainView.addSubview(nameLabel)

        imageView.addSubview(opacityLayer)
        imageView.addSubview(genderLabel)
        imageView.addSubview(statusLabel)
        imageView.contentMode = .redraw
    }
    
    func configure(with character: Character) {
        nameLabel.text = character.name
     
        imageView.sd_setImage(with: URL(string: character.image), placeholderImage: Images.placeholder.image)
        statusLabel.text = (character.status == "Alive") ? "😀" : "☠️"
        statusLabel.font = .systemFont(ofSize: 15)
        genderLabel.font = .systemFont(ofSize: 20)
        
        if character.gender == "Male" {
            genderLabel.text = "♂︎"

        } else if character.gender == "Female" {
            genderLabel.text = "♀︎"
        } else {
            genderLabel.text = "⚲"
        }
    }
}
