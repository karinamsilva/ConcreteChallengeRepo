//
//  MovieDetailCell.swift
//  ConcreteChallenge
//
//  Created by Karina on 17/07/22.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {
    
    let movieImage: UIImageView = {
        let movieImage = UIImageView()
        movieImage.contentMode = .scaleAspectFill
        movieImage.clipsToBounds = true
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        return movieImage
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = Colors.gray
        stackView.spacing = 2
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let movieName: UILabel = {
        let movieName = UILabel()
        movieName.numberOfLines = 0
        movieName.lineBreakMode = .byWordWrapping
        movieName.textColor = Colors.yellow
        movieName.textAlignment = .center
        movieName.translatesAutoresizingMaskIntoConstraints = false
        movieName.font = UIFont.systemFont(ofSize: 20)
        return movieName
    }()
    
    let likeButton: UIButton = {
        let likeButton = UIButton()
        likeButton.setImage(Constants.favoriteIconGray, for: .normal)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        return likeButton
        
    }()
    
    var delegate: MovieListViewDelegate?
    var movie: MoviesData?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupElements() {
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        stackView.addArrangedSubview(movieImage)
        imageStackView.addArrangedSubview(movieName)
        imageStackView.addArrangedSubview(likeButton)
        stackView.addArrangedSubview(imageStackView)
        contentView.addSubview(stackView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieImage.frame = contentView.bounds
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setConstraints() {

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            movieName.heightAnchor.constraint(equalToConstant: 50),
        ])
   
    }
    
    func setUpDelegate(delegate: MovieListViewDelegate) {
        self.delegate = delegate
    }
    
    func setSelectedMovie(movie: MoviesData) {
        self.movie = movie
    }
    
    func setUpLikeStatus(isFavorite: Bool) {
        isFavorite ? likeButton.setImage(Constants.favoriteIconFull, for: .normal) : likeButton.setImage(Constants.favoriteIconGray, for: .normal)
    }
    
    @objc func didTapLikeButton(sender: UIButton) {
        guard let movie = movie else { return }
        
        if sender.imageView?.image == Constants.favoriteIconGray {
            sender.setImage(Constants.favoriteIconFull, for: .normal)
            delegate?.selectedMovie(movie: movie)
        } else {
            sender.setImage(Constants.favoriteIconGray, for: .normal)
            delegate?.unselectedMovie(movie: movie)
        }
        
    }

}

