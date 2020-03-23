//
//  FavCell.swift
//  Rick and Morty Character Finder
//
//  Created by Murat Baykor on 21.03.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class FavCell: UITableViewCell {
    
    static let reuseID  = "FavCell"
    
    let avatarImageView = CFCharAvatarImageView(frame: .zero)
    let charNameLabel   = CFTitleLabel(textAlignment: .left, fontSize: 26)
    let charStatusLabel = CFSecondaryTitleLabel(fontSize: 16)
    let charSpeciesLabel = CFSecondaryTitleLabel(fontSize: 16)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(favoriteChar: FavChar) {
        avatarImageView.downloadImage(fromURL: favoriteChar.image)
        charNameLabel.text = favoriteChar.name
        charStatusLabel.text = favoriteChar.status
    }
    
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(charNameLabel)
        addSubview(charStatusLabel)
        isUserInteractionEnabled = false
        
        let padding: CGFloat    = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            charNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            charNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            charNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            charNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            charStatusLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            charStatusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            charStatusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            charStatusLabel.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
}
