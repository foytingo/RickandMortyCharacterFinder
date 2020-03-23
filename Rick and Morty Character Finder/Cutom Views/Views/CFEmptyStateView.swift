//
//  CFEmptyStateView.swift
//  Rick and Morty Character Finder
//
//  Created by Murat Baykor on 23.03.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import UIKit

class CFEmptyStateView: UIView {

    let messageLabel = CFTitleLabel(textAlignment: .center, fontSize: 24)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(message: String){
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    
    private func configure(){
        addSubview(messageLabel)
        
        messageLabel.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
        ])
    }

}
