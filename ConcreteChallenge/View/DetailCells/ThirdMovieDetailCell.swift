//
//  ThirdMovieDetailCell.swift
//  ConcreteChallenge
//
//  Created by Karina on 07/03/23.
//

import Foundation
import UIKit

class ThirdMovieDetailCell: UITableViewCell {
    let movieGenre: UILabel = {
        let movieGenre = UILabel()
        movieGenre.lineBreakMode = .byWordWrapping
        movieGenre.textColor = .black
        movieGenre.numberOfLines = 5
        movieGenre.textAlignment = .left
        movieGenre.font = UIFont.systemFont(ofSize: 18)
        movieGenre.translatesAutoresizingMaskIntoConstraints = false
        return movieGenre
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
        contentView.addSubview(movieGenre)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            movieGenre.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            movieGenre.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieGenre.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
