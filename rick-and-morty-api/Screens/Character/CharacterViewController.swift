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
    
    private let mainView = UIView()
    private let labelsView = UIView()
    private let imageView = UIImageView()

    private let nameLabel = UILabel()
    private let genderLabel = UILabel()
    private let statusLabel = UILabel()
    private let typeLabel = UILabel()
    
    private let mainStackView = UIStackView()
    private let stackView1 = UIStackView()
    private let stackView2 = UIStackView()
    
    private let episodesView = DetailView()
    private let genderView = DetailView()
    private let originView = DetailView()
    private let statusView = DetailView()
    
    // MARK: - Variables

    private var character: Character
    private let strings = Strings.CharacterView.self
    
    // MARK: - Functons
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.addSubview(mainView)
        
        imageView.sd_setImage(with: URL(string: character.image), placeholderImage: UIImage(named: "placeholder"))
        
        mainView.backgroundColor = UIColor(named: "backColor")
        
        nameLabel.text = character.name
        nameLabel.font = .preferredFont(forTextStyle: .largeTitle)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = .center
        
        labelsView.layer.cornerRadius = 20
        labelsView.clipsToBounds = true
        labelsView.backgroundColor = UIColor(named: "backColor")
        
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        stackView1.axis = .horizontal
        stackView1.distribution = .fillEqually
        stackView1.alignment = .fill
        
        stackView2.axis = .horizontal
        stackView2.distribution = .fillEqually
        stackView2.alignment = .fill
        stackView2.spacing = 0
        
        episodesView.configure(image: UIImage(named: "tv")?.withRenderingMode(.alwaysTemplate), text: "\(character.episode.count) \(strings.episodesLabel)")
        
        genderView.configure(image: UIImage(named: "gender")?.withRenderingMode(.alwaysTemplate), text: "\(character.gender)")
        
        originView.configure(image: UIImage(named: "origin")?.withRenderingMode(.alwaysTemplate), text: "\(character.origin.name)")
        
        statusView.configure(image: UIImage(named: "status")?.withRenderingMode(.alwaysTemplate), text: "\(character.status)")
        
        mainView.addSubview(imageView)
        mainView.addSubview(labelsView)
        labelsView.addSubview(nameLabel)
        labelsView.addSubview(genderLabel)
        labelsView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(stackView1)
        mainStackView.addArrangedSubview(stackView2)
        
        stackView1.addArrangedSubview(episodesView)
        stackView1.addArrangedSubview(genderView)
        
        stackView2.addArrangedSubview(originView)
        stackView2.addArrangedSubview(statusView)
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(labelsView).offset(10)
            make.trailing.leading.equalToSuperview().inset(15)
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
