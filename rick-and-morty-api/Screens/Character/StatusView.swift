//
//  StatusView.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 28/08/2023.
//

import Foundation
import SnapKit
import UIKit

class StatusView: UIView {
    private let imageView = UIImageView()
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupSubviews() {
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        
        label.textColor = UIColor(named: "textColor")
        label.textAlignment = .center
        label.numberOfLines = 2
        imageView.tintColor = label.textColor
        
        addSubview(imageView)
        addSubview(label)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    }

    func configure(image: UIImage?, text: String) {
        imageView.image = image
        label.text = text
    }
}
