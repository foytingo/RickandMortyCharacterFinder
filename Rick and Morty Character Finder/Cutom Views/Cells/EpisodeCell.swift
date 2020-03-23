//
//  EpisodeCell.swift
//  Rick and Morty Character Finder
//
//  Created by Murat Baykor on 21.03.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    static let reuseID = "EpisodeCell"
    
    let episodeLabel = CFTitleLabel(textAlignment: .left, fontSize: 15)
    let episodeNameLabel = CFSecondaryTitleLabel(fontSize: 15)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(episode: Episode){
        episodeLabel.text = episode.episode
        episodeNameLabel.text = episode.name
    }
    
    
    private func configure(){
        addSubview(episodeLabel)
        addSubview(episodeNameLabel)
        
        NSLayoutConstraint.activate([
            episodeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            episodeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            episodeLabel.heightAnchor.constraint(equalToConstant: 18),
            episodeLabel.widthAnchor.constraint(equalToConstant: 60),
            
            episodeNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            episodeNameLabel.leadingAnchor.constraint(equalTo: episodeLabel.trailingAnchor, constant: 15),
            episodeNameLabel.heightAnchor.constraint(equalToConstant: 18),
            episodeNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
