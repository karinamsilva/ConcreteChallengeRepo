//
//  MovieViewModel.swift
//  ConcreteChallenge
//
//  Created by Karina on 18/07/22.
//

import Foundation
import Kingfisher

protocol MovieListViewDelegate: AnyObject {
    func selectedMovie(movie: MoviesData)
    func unselectedMovie(movie: MoviesData)
}

class MovieViewModel: NSObject {
    
    var repository = MovieService()
    var repositoryMock = MockedService()
    var movies : [MoviesData] = []
    var didUpdateMovies: (([MoviesData])->Void)?
    var didSelectMovie: (()-> Void)?
    
    func requestMovies(completion: @escaping(Bool) -> Void) {
        repository.request(completion: { movies in
            switch movies {
            case .success(let movie):
                self.movies = movie
                completion(true)
            case .failure(let error):
                print(String(describing: error))
                completion(false)
            }
        })
    }
    
    func saveMovie(movie: MoviesData) {
        return PersistenceManager().save(movie: movie)
    }
    
    func isFavoriteMovie(movie: MoviesData) -> Bool {
        return PersistenceManager().hasMovie(id: movie.id)
    }
    
    func deleteMovie(movie: MoviesData) {
        return PersistenceManager().deleteMovie(id: movie.id)
    }
    
    func configureMovieCell(with movieArray: [MoviesData], indexPath: IndexPath, movieCell: MovieCollectionCell) -> MovieCollectionCell {
        movieCell.movieImage.kf.setImage(with: URL(string: movieArray[indexPath.row].posterImage))
        movieCell.movieName.text = movieArray[indexPath.row].title
        movieCell.likeButton.tag =  movieArray[indexPath.row].id
        movieCell.setUpDelegate(delegate: self)
        movieCell.setUpLikeStatus(isFavorite: isFavoriteMovie(movie: movieArray[indexPath.row]))
        movieCell.setSelectedMovie(movie: movieArray[indexPath.row])
        
        return movieCell
    }
}

extension MovieViewModel: MovieListViewDelegate {
    func selectedMovie(movie: MoviesData) {
        saveMovie(movie: movie)
    }
    
    func unselectedMovie(movie: MoviesData) {
        deleteMovie(movie: movie)
    }
}
