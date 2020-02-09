//
//  ObjetivoTableViewCell.swift
//  BuildApp
//
//  Created by Eduardo Varela on 09/02/20.
//  Copyright © 2020 Eduardo Varela. All rights reserved.
//

import UIKit

class ObjetivoTableViewCell: UITableViewCell {
    let nameLabel: UILabel = UILabel()
    let totalLabel: UILabel = UILabel()
    let goalAmountLabel: UILabel = UILabel()
    let goalDateLabel: UILabel = UILabel()
    let backgroundImageView: UIImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(backgroundImageView)
        self.addSubview(nameLabel)
        self.addSubview(totalLabel)
        self.addSubview(goalAmountLabel)
        self.addSubview(goalDateLabel)
        
        //Background
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        //Name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        //Total
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        totalLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        //Goal Amount
        goalAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        goalAmountLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        goalAmountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        //Goal Date
        goalDateLabel.translatesAutoresizingMaskIntoConstraints = false
        goalDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        goalDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
