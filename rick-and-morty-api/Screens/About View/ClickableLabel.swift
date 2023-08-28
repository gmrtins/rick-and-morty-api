//
//  ClickableLabel.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 28/08/2023.
//

import UIKit

class ClickableLabel: UILabel {
    var linkURL: URL?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openLink))
        addGestureRecognizer(tapGesture)
        
        font = UIFont.systemFont(ofSize: 16)
    }

    @objc private func openLink() {
        if let url = linkURL {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
