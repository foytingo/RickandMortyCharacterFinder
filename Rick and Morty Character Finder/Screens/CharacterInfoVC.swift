//
//  CharacterInfoVC.swift
//  Rick and Morty Character Finder
//
//  Created by Murat Baykor on 18.03.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class CharacterInfoVC: CFDataLoadingVC {
    
    var character: Character!
    var episodes : [Episode] = []
    let headerView = CFCharInfoHeaderView()
    let episodesLabel = CFTitleLabel(textAlignment: .left, fontSize: 26)
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureHeaderView()
         getEpisodes(episodes: character.episode.map{ $0.replacingOccurrences(of: "https://rickandmortyapi.com/api/episode/", with: "")})
        configureData(with: character)
        configureEpisodesLabel()
        configureTableView()
    }
    
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = character.name
        //navigationController?.navigationBar.prefersLargeTitles = true
        
        let addFav = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addFav
    }
    
    @objc func addButtonTapped() {
        print("Add button tapped")
    }
    
    
    private func configureHeaderView(){
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            headerView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

    
    private func configureEpisodesLabel(){
        if character.episode.count > 1 {
            episodesLabel.text = "Episodes"
        } else {
            episodesLabel.text = "Episode"
        }
        
        view.addSubview(episodesLabel)
        NSLayoutConstraint.activate([
            episodesLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 15),
            episodesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            episodesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            episodesLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: episodesLabel.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)
        ])
        
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: EpisodeCell.reuseID)
    }
    
    func getEpisodes(episodes: [String]) {
        showLoadingView()
        NetworkManager.shared.getMultipleEpisode(episodes: episodes) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result {
            case .success(let episodes):
                self.updateUI(on: episodes)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateUI(on episodes: [Episode]) {
        self.episodes.append(contentsOf: episodes)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func configureData(with character: Character) {
        headerView.set(with: character)
    }
}


extension CharacterInfoVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.reuseID) as! EpisodeCell
        cell.isUserInteractionEnabled = false
        cell.set(episode: episodes[indexPath.row])
        return cell
    }
}


