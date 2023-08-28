//
//  AboutViewController.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 24/08/2023.
//

import Foundation
import UIKit
import SDWebImage

class AboutViewController: UIViewController {
    // MARK: - UI Elements
    
    private let mainView = UIView()
    private let nameLabel = {
        let label = UILabel()
        label.text = "Gonçalo Martins"
        label.textAlignment = .center
        label.textColor = UIColor(named: "textColor")
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let iconImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 75
        imageView.layer.borderWidth = 2 // Border width
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        imageView.sd_setImage(with: URL(string: "https://avatars.githubusercontent.com/u/49563508?v=4"), placeholderImage: UIImage(named: "placeholder"))
        return imageView
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.text = "Hi, my name is Gonçalo Martins, I'm an iOS developer from Coimbra, Portugal. If you want to know a litle bit more about me and the projects I've worked on, you can click the link bellow"
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingHead
        return label
    }()
    
    private let linktreeLabel = {
        let label = ClickableLabel()
        label.linkURL = URL(string: "https://linktr.ee/goncalomartins.dev")
        label.textAlignment = .center

        let attributedText = NSAttributedString(string: "Get to know me!", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(named: "textColor"),
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        
        label.attributedText = attributedText
        return label
    }()
    
    private let projectReadme = {
        let label = ClickableLabel()
        label.linkURL = URL(string: "https://linktr.ee/goncalomartins.dev")
        label.textAlignment = .center
        
        let attributedText = NSAttributedString(string: "Project README", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(named: "textColor"),
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        
        label.attributedText = attributedText
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.addSubview(mainView)
        
        mainView.addSubview(iconImageView)
        mainView.addSubview(nameLabel)
        mainView.addSubview(descriptionLabel)
        mainView.addSubview(linktreeLabel)
        mainView.addSubview(projectReadme)
        
        view.backgroundColor = UIColor(named: "backColor")
        mainView.backgroundColor = UIColor(named: "backColor")
        
        
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)

        }
        linktreeLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
        
        projectReadme.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
}
