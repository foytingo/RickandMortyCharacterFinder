//
//  PersistenceManager.swift
//  Rick and Morty Character Finder
//
//  Created by Murat Baykor on 21.03.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    enum Keys { static let favorites = "favorites" }
    
    
    static func updateWith(favorite: FavChar, actionType: PersistenceActionType, completed: @escaping(CFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case.success(var favorites):
                
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    favorites.append(favorite)
                    
                case .remove:
                    favorites.removeAll { $0.name == favorite.name }
                }
                
                completed(save(favorites: favorites))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrieveFavorites(completed: @escaping (Result<[FavChar],CFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([FavChar].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [FavChar]) -> CFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
}
