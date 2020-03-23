//
//  EpisodeInfoVC.swift
//  Rick and Morty Character Finder
//
//  Created by Murat Baykor on 18.03.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class EpisodeInfoVC: CFDataLoadingVC{
    
    enum Section { case main }
    var episode: Episode!
    var characters : [Character] = []
    var filteredCharacters : [Character] = []
    var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Character>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = episode.name
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getCharacters(characters: getCharacterIdfromUrl(array: episode.characters))
        
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CharCell.self, forCellWithReuseIdentifier: CharCell.reuseID)
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a character's name"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    
    func getCharacters(characters: [String]) {
        showLoadingView()
        NetworkManager.shared.getMultipleCharacter(characters: characters) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result {
            case .success(let characters):
                self.updateUI(with: characters)
            case .failure(let error):
                self.presentAlertOnMainThread(alertTitle: "Something went wrong", alertMessage: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func updateUI(with characters: [Character]) {
        self.characters.append(contentsOf: characters)
        self.updateData(on: self.characters)
    }
    
    
    func updateData(on characters: [Character]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Character>()
        snapshot.appendSections([.main])
        snapshot.appendItems(characters)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot,animatingDifferences: true)
        }
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Character>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, charater) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharCell.reuseID, for: indexPath) as! CharCell
            cell.set(char: charater)
            return cell
        })
    }
}


extension EpisodeInfoVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredCharacters : characters
        let character = activeArray[indexPath.item]
        let destVC = CharacterInfoVC()
        destVC.character = character
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}


extension EpisodeInfoVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredCharacters.removeAll()
            updateData(on: characters)
            isSearching = false
            return
        }
        isSearching = true
        filteredCharacters = characters.filter {
            $0.name.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredCharacters)
    }    
}

