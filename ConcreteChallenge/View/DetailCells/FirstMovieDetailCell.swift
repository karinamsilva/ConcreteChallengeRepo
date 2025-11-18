//
//  FirstMovieDetailCell.swift
//  ConcreteChallenge
//
//  Created by Karina on 07/03/23.
//

import UIKit

class FirstMovieDetailCell: UITableViewCell {
    
    let movieImage: UIImageView = {
       let movieImage = UIImageView()
        movieImage.contentMode = .scaleAspectFit
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        return movieImage
    }()
    
    let movieName: UILabel = {
        let movieName = UILabel()
        movieName.numberOfLines = 3
        movieName.lineBreakMode = .byWordWrapping
        movieName.textColor = .black
        movieName.textAlignment = .left
        movieName.font = UIFont.systemFont(ofSize: 20)
        movieName.translatesAutoresizingMaskIntoConstraints = false
        return movieName
    }()
    
    let heartButton: UIButton = {
        let heartButton = UIButton()
        heartButton.contentMode = .right
        heartButton.setImage(Constants.favoriteIconGray, for: .normal)
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        return heartButton
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var delegate: MovieListViewDelegate?
    private var movie: MoviesData?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        heartButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        setUpItems()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDelegate(delegate: MovieListViewDelegate) {
        self.delegate = delegate
    }
    
    func setSelectedMovie(movie: MoviesData) {
        self.movie = movie
    }
    
    func setUpItems() {
        contentView.addSubview(movieImage)
        stackView.addArrangedSubview(movieName)
        stackView.addArrangedSubview(heartButton)
        contentView.addSubview(stackView)
    }
    
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            movieImage.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            movieImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            movieImage.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            movieImage.heightAnchor.constraint(equalToConstant: 320),
            
            stackView.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: movieImage.bottomAnchor, multiplier: 2),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setUpLikeStatus(isFavorite: Bool) {
        isFavorite ? heartButton.setImage(Constants.favoriteIconFull, for: .normal) : heartButton.setImage(Constants.favoriteIconGray, for: .normal)
    }
    
    @objc func likeTapped(sender: UIButton) {
        guard let movie = movie else {return}
        if sender.imageView?.image == Constants.favoriteIconGray {
            heartButton.setImage(Constants.favoriteIconFull, for: .normal)
            delegate?.selectedMovie(movie: movie)
        } else {
            heartButton.setImage(Constants.favoriteIconGray, for: .normal)
            delegate?.unselectedMovie(movie: movie)
        }
    }
}
