//
//  SecondMovieDetailCell.swift
//  ConcreteChallenge
//
//  Created by Karina on 07/03/23.
//

import UIKit

class SecondMovieDetailCell: UITableViewCell {
    
    let movieYear: UILabel = {
        let movieYear = UILabel()
        movieYear.lineBreakMode = .byWordWrapping
        movieYear.textColor = .black
        movieYear.numberOfLines = 1
        movieYear.textAlignment = .left
        movieYear.font =  UIFont.systemFont(ofSize: 20)
        movieYear.translatesAutoresizingMaskIntoConstraints = false
        return movieYear
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
        contentView.addSubview(movieYear)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            movieYear.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            movieYear.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieYear.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
