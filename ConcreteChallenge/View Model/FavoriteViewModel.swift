//
//  FavoriteViewModel.swift
//  ConcreteChallenge
//
//  Created by Karina on 07/03/23.
//

import Foundation

class FavoriteViewModel {
    
    var savedMovies: [MoviesData] = []
    
    func loadSavedMovies() {
        savedMovies = PersistenceManager().getAllMovies()
    }
    
    func deleteMovie(selectedMovie: MoviesData) {
        PersistenceManager().deleteMovie(id: selectedMovie.id)
    }
    
    func formatData(movieDisplaying: String) -> String {
        //get it to date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let data = dateFormatter.date(from: movieDisplaying)
        //get it back to string
        dateFormatter.dateFormat = "yyyy"
        let value = dateFormatter.string(from: data!)
        return value
    }
    
    func configureMovieCell(with movieArray: [MoviesData], indexPath: IndexPath, movieCell: FavoritesTableViewCell) -> FavoritesTableViewCell {
        movieCell.movieImage.kf.setImage(with: URL(string: movieArray[indexPath.row].posterImage))
        movieCell.movieTitle.text = movieArray[indexPath.row].title
        movieCell.movieYear.text =  formatData(movieDisplaying: movieArray[indexPath.row].releaseDate)
        movieCell.movieDescription.text = movieArray[indexPath.row].overview
        movieCell.backgroundColor = .systemGray4
        
        return movieCell
    }

    
}
