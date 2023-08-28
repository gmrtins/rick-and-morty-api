//
//  AboutViewController.swift
//  rick-and-morty-api
//
//  Created by Gonçalo Martins on 24/08/2023.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {
    // MARK: - UI Elements

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        view.backgroundColor = UIColor(hex: "#333333")
    }
}
