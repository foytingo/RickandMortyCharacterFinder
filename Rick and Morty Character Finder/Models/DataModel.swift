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

struct Episodes: Codable {
    let info: Info
    let results: [Episode]
}

struct Info: Codable {
    let count : Int
    let pages : Int
}


struct Episode: Codable, Hashable{
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
}


struct Character: Codable, Hashable {
    let id : Int
    let name : String
    let status : String
    let type : String
    let gender : String
    let image : String
    let episode : [String]
    let url : String
    
}
