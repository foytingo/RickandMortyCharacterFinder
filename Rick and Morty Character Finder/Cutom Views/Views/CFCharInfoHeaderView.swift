//
//  CFCharInfoHeaderView.swift
//  Rick and Morty Character Finder
//
//  Created by Murat Baykor on 19.03.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class CFCharInfoHeaderView: UIView {
    
    let avatarImageView = CFCharAvatarImageView(frame: .zero)
    let charGenderLabel = CFSecondaryTitleLabel(fontSize: 15)
    let charStatusLabel = CFSecondaryTitleLabel(fontSize: 15)
    let charSpeciesLabel = CFSecondaryTitleLabel(fontSize: 15)
    let charTypeLabel = CFSecondaryTitleLabel(fontSize: 15)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        layoutUI()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configureView() {
        layer.cornerRadius = 10
        backgroundColor = .secondarySystemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func set(with character: Character){
        avatarImageView.downloadImage(fromURL: character.image)
        charGenderLabel.text = "Gender: " + character.gender
        charStatusLabel.text = "Status: " + character.status
        charSpeciesLabel.text = "Species: \(character.species)"
        if character.type == ""{
            charTypeLabel.text = "Type: -"
        } else {
            charTypeLabel.text = "Type: \(character.type)"
        }
    }
    
    
    private func layoutUI() {
        let padding: CGFloat = 10
        let paddingTop: CGFloat = 5
        
        addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100)
        ])

        addSubview(charGenderLabel)
        
        NSLayoutConstraint.activate([
            charGenderLabel.topAnchor.constraint(equalTo:topAnchor, constant: padding),
            charGenderLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            charGenderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            charGenderLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        addSubview(charStatusLabel)
        
        NSLayoutConstraint.activate([
            charStatusLabel.topAnchor.constraint(equalTo: charGenderLabel.bottomAnchor, constant: paddingTop),
            charStatusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            charStatusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            charStatusLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        addSubview(charSpeciesLabel)
        
        NSLayoutConstraint.activate([
            charSpeciesLabel.topAnchor.constraint(equalTo: charStatusLabel.bottomAnchor, constant: paddingTop),
            charSpeciesLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            charSpeciesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            charSpeciesLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        addSubview(charTypeLabel)
       
        NSLayoutConstraint.activate([
            charTypeLabel.topAnchor.constraint(equalTo: charSpeciesLabel.bottomAnchor, constant: paddingTop),
            charTypeLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            charTypeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            charTypeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
