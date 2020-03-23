//
//  UIViewController+Ext.swift
//  Rick and Morty Character Finder
//
//  Created by Murat Baykor on 23.03.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlertOnMainThread(alertTitle: String, alertMessage: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: buttonTitle, style: .default)
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func showEmptyStateView(with message: String, in tableView: UITableView){
        let emptyStateView = CFEmptyStateView(message: message)
        tableView.backgroundView = emptyStateView
    }
    
     func getEpisodeIdfromUrl(array: [String])->[String]{
           return array.map{ $0.replacingOccurrences(of: "https://rickandmortyapi.com/api/episode/", with: "")}
       }
    
    func getCharacterIdfromUrl(array: [String])->[String]{
        return array.map{ $0.replacingOccurrences(of: "https://rickandmortyapi.com/api/character/", with: "")}
    }
}
