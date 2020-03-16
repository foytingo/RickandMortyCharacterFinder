//
//  CFTabBarController.swift
//  Rick and Morty Character Finder
//
//  Created by Murat Baykor on 16.03.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class CFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createCharactersNC(),createEpisodesNC(),createFavoritesNC()]
    }
    
    func createCharactersNC() -> UINavigationController {
        let charactersVC = CharactersVC()
        charactersVC.title = "Characters"
        charactersVC.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 0)
        
        return UINavigationController(rootViewController: charactersVC)
    }
    
    func createEpisodesNC() -> UINavigationController {
        let episodesVC = EpisodesVC()
        episodesVC.title = "Episodes"
        episodesVC.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 1)
        
        return UINavigationController(rootViewController: episodesVC)
    }
    
    func createFavoritesNC() -> UINavigationController {
           let favoritesVC = FavoritesVC()
           favoritesVC.title = "Favorites"
           favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 2)
           
           return UINavigationController(rootViewController: favoritesVC)
       }

    

}
