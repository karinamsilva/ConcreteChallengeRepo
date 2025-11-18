//
//  FavoritesTableViewCell.swift
//  ConcreteChallenge
//
//  Created by Karina on 07/03/23.
//

import Foundation
import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    let movieImage: UIImageView = {
        let movieImage = UIImageView()
        movieImage.contentMode = .left
        movieImage.clipsToBounds = true
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        return movieImage
    }()
    
    let movieTitle: UILabel = {
       let movieTitle = UILabel()
        movieTitle.textAlignment = .left
        movieTitle.numberOfLines = 3
        movieTitle.lineBreakMode = .byWordWrapping
        movieTitle.font = UIFont.systemFont(ofSize: 17)
        movieTitle.textColor = .black
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        return movieTitle
    }()
    
    let movieYear: UILabel = {
        let movieYear = UILabel()
        movieYear.textColor = .black
        movieYear.textAlignment = .right
        movieYear.font =  UIFont.systemFont(ofSize: 15)
        movieYear.translatesAutoresizingMaskIntoConstraints = false
        return movieYear
    }()
    
    let movieDescription: UILabel = {
       let movieDescription = UILabel()
        movieDescription.textAlignment = .left
        movieDescription.numberOfLines = 4
        movieDescription.lineBreakMode = .byWordWrapping
        movieDescription.font = UIFont.systemFont(ofSize: 12)
        movieDescription.translatesAutoresizingMaskIntoConstraints = false
        return movieDescription
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .white
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
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
        contentView.addSubview(movieImage)
        
        horizontalStackView.addArrangedSubview(movieTitle)
        horizontalStackView.addArrangedSubview(movieYear)
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(movieDescription)
        verticalStackView.addArrangedSubview(separator)
        
        contentView.addSubview(verticalStackView)
        contentView.addSubview(separator)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            movieImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImage.topAnchor.constraint(equalTo: topAnchor),
            movieImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            movieImage.widthAnchor.constraint(equalToConstant: 150),
            
            verticalStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: movieImage.trailingAnchor, multiplier: 1),
            verticalStackView.topAnchor.constraint(equalTo: topAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            verticalStackView.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor),
            
            separator.topAnchor.constraint(equalTo: movieImage.bottomAnchor),
            separator.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            separator.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}
