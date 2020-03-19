//
//  NetworkManager.swift
//  Rick and Morty Character Finder
//
//  Created by Murat Baykor on 16.03.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://rickandmortyapi.com/api/"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getAllEpisodes(page:Int, completed: @escaping (Result<Episodes, CFError>) -> Void){
        let endpoint = baseURL + "/episode/?page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let episodes = try decoder.decode(Episodes.self, from: data)
                completed(.success(episodes))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getMultipleEpisode(episodes: [String], completed: @escaping (Result<[Episode], CFError>) -> Void) {
        var endpoint = baseURL + "/episode/"
        
        for episode in episodes {
            endpoint += "," + episode
        }
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let episodes = try decoder.decode([Episode].self, from: data)
                completed(.success(episodes))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    func getAllChar(page: Int, completed: @escaping (Result<Characters, CFError>) -> Void) {
        let endpoint = baseURL + "/character/?page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode(Characters.self, from: data)
                completed(.success(characters))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
        
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
        
    }
}
