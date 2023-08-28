//
//  CharacterViewController.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 25/08/2023.
//

import Foundation
import SDWebImage
import SnapKit
import UIKit

class CharacterViewController: UIViewController {
    // MARK: - UI Elements

    private var character: Character
    private let mainView = UIView()
    private let imageView = UIImageView()
    private let labelsView = UIView()

    private let nameLabel = UILabel()
    private let genderLabel = UILabel()
    private let statusLabel = UILabel()
    private let typeLabel = UILabel()
    
    let mainStackView = UIStackView()
    let stackView1 = UIStackView()
    let stackView2 = UIStackView()
    let episodesView = StatusView()
    let originView = StatusView()
    let episodesView2 = StatusView()
    let episodesView3 = StatusView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        
        episodesView.configure(image: UIImage(named: "tv")?.withRenderingMode(.alwaysTemplate), text: "\(character.episode.count) Episodes")
        
        originView.configure(image: UIImage(named: "gender")?.withRenderingMode(.alwaysTemplate), text: "\(character.gender)")
        
        episodesView2.configure(image: UIImage(named: "origin")?.withRenderingMode(.alwaysTemplate), text: "\(character.origin.name)")
        
        episodesView3.configure(image: UIImage(named: "status")?.withRenderingMode(.alwaysTemplate), text: "\(character.status)")
    }

    private func setupView() {
        view.addSubview(mainView)
        mainView.addSubview(imageView)
        mainView.addSubview(labelsView)
        labelsView.addSubview(nameLabel)
        labelsView.addSubview(genderLabel)

//        imageView.sd_setImage(with: URL(string: character.image), completed: nil)
        imageView.sd_setImage(with: URL(string: character.image), placeholderImage: UIImage(named: "placeholder"))
        mainView.backgroundColor = .systemBackground
        
        nameLabel.text = character.name
        nameLabel.font = .preferredFont(forTextStyle: .largeTitle)
        nameLabel.adjustsFontSizeToFitWidth = true
//        imageView.layer.cornerRadius = 30
//        imageView.clipsToBounds = true
//        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        labelsView.layer.cornerRadius = 20
        labelsView.clipsToBounds = true
        labelsView.backgroundColor = .systemBackground
        nameLabel.textAlignment = .center
        
//        episodesView.backgroundColor = .green
//        episodesView1.backgroundColor = .systemPink
//        episodesView2.backgroundColor = .blue
//        episodesView3.backgroundColor = .gray
//
//        episodesView.layer.borderWidth = 1
//        episodesView.layer.borderColor = UIColor.red.cgColor
        labelsView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(stackView1)
        mainStackView.addArrangedSubview(stackView2)
        mainView.backgroundColor = UIColor(named: "backColor")
        labelsView.backgroundColor = UIColor(named: "backColor")
        
//        labelsView.backgroundColor = UIColor(hex: "#333333")
//        labelsView.backgroundColor = UIColor(hex: "#333333")
        
//        mainStackView.backgroundColor = UIColor(named: "backColor")
        mainStackView.axis = .vertical
//        stackView.alignment = .
        mainStackView.distribution = .fillEqually
//        mainStackView.spacing =
        
        stackView1.axis = .horizontal
        stackView2.axis = .horizontal
//        stackView.alignment = .
        stackView1.distribution = .fillEqually
        stackView1.alignment = .fill

        stackView2.distribution = .fillEqually
        stackView2.alignment = .fill
        stackView2.spacing = 0
       
        stackView1.addArrangedSubview(episodesView)

        stackView1.addArrangedSubview(originView)
        stackView2.addArrangedSubview(episodesView2)

        stackView2.addArrangedSubview(episodesView3)
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(labelsView).offset(10)
            make.trailing.leading.equalToSuperview().inset(15)
//            make.trailing.leading.lessThanOrEqualToSuperview().offset(15)
//            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        labelsView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(25)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(mainStackView.snp.width)
        }
    }
    
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
