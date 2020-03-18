//
//  EpisodesVC.swift
//  Rick and Morty Character Finder
//
//  Created by Murat Baykor on 16.03.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class EpisodesVC: CFDataLoadingVC {
    var episodes : [Episode] = []
    var totalPage: Int!
    var page = 1
    var isLoadingMoreChar = false
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getEpisodes(page: page)
        
        
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func updateUI(on episodes: [Episode]) {
        self.episodes.append(contentsOf: episodes)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func getEpisodes(page: Int){
        showLoadingView()
        isLoadingMoreChar = true
        NetworkManager.shared.getAllEpisodes(page: page) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result {
            case .success(let episodes):
                self.updateUI(on: episodes.results)
                self.totalPage = episodes.info.pages
            case .failure(let error):
                print(error)
            }
            self.isLoadingMoreChar = false
        }
    }
    
}

extension EpisodesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "\(episodes[indexPath.row].episode): \(episodes[indexPath.row].name)"
        return cell
    }
}

extension EpisodesVC: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
     
        if offsetY > contentHeight - height {
            guard !isLoadingMoreChar, page<totalPage else { return }
            page += 1
            getEpisodes(page: page)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.item]
        
        let destVC = EpisodeInfoVC()
        destVC.episodeID = episode.id
        destVC.episodeName = episode.episode
        navigationController?.pushViewController(destVC, animated: true)
    }
}
