//
//  CharactersVC.swift
//  Rick and Morty Character Finder
//
//  Created by Murat Baykor on 16.03.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class CharactersVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemTeal
        NetworkManager.shared.getAllChar(page: 1) { [weak self] result in
            guard self != nil else {return}
            
            switch result {
            case .success(let charaters):
                print(charaters.info.pages)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }

}
