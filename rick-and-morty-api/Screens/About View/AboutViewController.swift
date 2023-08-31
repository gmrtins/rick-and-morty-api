//
//  AboutViewController.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 24/08/2023.
//

import Foundation
import SDWebImage
import UIKit

class AboutViewController: UIViewController {
    // MARK: - UI Elements

    let strings = Strings.AboutView.self
    
    private let mainView = UIView()
    
    private let nameLabel = {
        let label = UILabel()
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
        return imageView
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingHead
        return label
    }()
    
    private let linktreeLabel = {
        let label = ClickableLabel()
        label.textAlignment = .center
        return label
    }()
    
    private let projectReadme = {
        let label = ClickableLabel()
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLabels()
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
        iconImageView.sd_setImage(with: URL(string: strings.iconURL), placeholderImage: Images.placeholder.image)

    }
    
    private func setupLabels() {
        nameLabel.text = strings.nameLabel
        descriptionLabel.text = strings.descriptionLabel
        
        let projectReadmeText = NSAttributedString(string: strings.readmeTitle, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(named: "textColor") ?? .systemBackground,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        
        projectReadme.attributedText = projectReadmeText
        projectReadme.linkURL = URL(string: strings.readmeURL)
        
        let linktreeText = NSAttributedString(string: strings.linktreeTitle, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(named: "textColor") ?? .systemBackground,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        
        linktreeLabel.attributedText = linktreeText
        linktreeLabel.linkURL = URL(string: strings.linktreeURL)
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
