//
//  ProductCell.swift
//  MyApp
//
//  Created by Satsishur on 15.07.2020.
//  Copyright © 2020 Consumeda. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    let codeLabel = UILabel()
    let descriptionLabel = UILabel()
    let amountLabel = UILabel()

    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let marginGuide = contentView.layoutMarginsGuide
        // configure codeLabel
        contentView.addSubview(codeLabel)
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        codeLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        codeLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        codeLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        codeLabel.numberOfLines = 0
        codeLabel.font = UIFont.systemFont(ofSize: 16)
        //configure amountLabel
        contentView.addSubview(amountLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.centerYAnchor.constraint(equalTo: marginGuide.centerYAnchor).isActive = true
        amountLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        amountLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        amountLabel.textAlignment = .right
        // configure descriptionLabel
        contentView.addSubview(descriptionLabel)
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: codeLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: amountLabel.leadingAnchor, constant: -30).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = UIColor.darkGray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
