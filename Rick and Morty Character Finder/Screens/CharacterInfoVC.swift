//
//  CharacterInfoVC.swift
//  Rick and Morty Character Finder
//
//  Created by Murat Baykor on 18.03.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class CharacterInfoVC: UIViewController {

    var characterID: Int!
    var characterName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = characterName
        print(characterID!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
