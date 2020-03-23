//
//  CharactersVC.swift
//  Rick and Morty Character Finder
//
//  Created by Murat Baykor on 16.03.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class CharactersVC: CFDataLoadingVC {
    
    enum Section { case main }
    var characters : [Character] = []
    var filteredCharacters : [Character] = []
    var page = 1
    var isLoadingMoreChar = false
    var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Character>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getCharacters(page: page)
        configureDataSource()
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
    
    func getCharacters(page: Int){
        showLoadingView()
        isLoadingMoreChar = true
        NetworkManager.shared.getAllChar(page: page) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result {
            case .success(let characters):
                self.updateUI(with: characters.results)
            case .failure(let error):
                 self.presentAlertOnMainThread(alertTitle: "Something went wrong", alertMessage: error.rawValue, buttonTitle: "Ok")
            }
            self.isLoadingMoreChar = false
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

extension CharactersVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard !isLoadingMoreChar else { return }
            page += 1
            getCharacters(page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredCharacters : characters
        let character = activeArray[indexPath.item]
        
        let destVC = CharacterInfoVC()
        destVC.character = character
        let navController = UINavigationController(rootViewController: destVC)
        //navigationController?.pushViewController(destVC, animated: true)
        present(navController, animated: true)
    }
}

extension CharactersVC: UISearchResultsUpdating {
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
