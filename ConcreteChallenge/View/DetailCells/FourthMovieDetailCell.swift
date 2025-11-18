//
//  FourthMovieDetailCell.swift
//  ConcreteChallenge
//
//  Created by Karina on 07/03/23.
//

import Foundation
import UIKit

class FourthMovieDetailCell: UITableViewCell {
    let movieDescription: UILabel = {
        let movieDescription = UILabel()
        movieDescription.lineBreakMode = .byWordWrapping
        movieDescription.numberOfLines = 4
        movieDescription.textColor = .black
        movieDescription.textAlignment = .left
        movieDescription.font = UIFont.systemFont(ofSize: 15)
        movieDescription.translatesAutoresizingMaskIntoConstraints = false
        return movieDescription
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpItems()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpItems() {
        contentView.addSubview(movieDescription)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            movieDescription.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            movieDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            movieDescription.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
