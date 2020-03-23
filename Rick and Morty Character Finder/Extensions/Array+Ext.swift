//
//  Array+Ext.swift
//  Rick and Morty Character Finder
//
//  Created by Murat Baykor on 23.03.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import Foundation

extension Character {
    func getIdfromUrl(array: [String])->[String]{
        return array.map{ $0.replacingOccurrences(of: "https://rickandmortyapi.com/api/episode/", with: "")}
    }
}
