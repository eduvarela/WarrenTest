//
//  MainViewController.swift
//  BuildApp
//
//  Created by Eduardo Varela on 27/01/20.
//  Copyright © 2020 Eduardo Varela. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        navigationItem.title = "Tela Principal"
        navigationController?.navigationBar.isTranslucent = false
    }
}
