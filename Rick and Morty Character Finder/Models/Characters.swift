//
//  Characters.swift
//  Rick and Morty Character Finder
//
//  Created by Murat Baykor on 16.03.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import Foundation

struct Characters: Codable {
    let info : Info
    let results: [Character]
}

struct Info: Codable {
    let count : Int
    let pages : Int
}

struct Character: Codable {
    let id : Int
    let name : String
    let status : String
    let type : String
    let gender : String
    let image : String
    let episode : [String]
    let url : String
    
}
