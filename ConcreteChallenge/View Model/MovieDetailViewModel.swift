//
//  MovieDetailViewModel.swift
//  ConcreteChallenge
//
//  Created by Karina on 07/03/23.
//

import Foundation

class MovieDetailViewModel {
    var mockRepository = MockedService()
    var genreService = MovieService()
    var genres: [Genre] = []
    var movies: MoviesData?
    
    func requestGenre() {
        genreService.requestGenre { result in
            switch result {
            case .success(let genre):
                self.genres = genre
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func isFavoriteMovie(movie: MoviesData) -> Bool {
        return PersistenceManager().hasMovie(id: movie.id)
    }
    
    func saveMovie(movie: MoviesData) {
        return PersistenceManager().save(movie: movie)
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
    
    func configureFirstCell(movie: MoviesData, cell: FirstMovieDetailCell) -> FirstMovieDetailCell {
        cell.movieImage.loadImage(fromString: movie.posterImage)
        cell.movieName.text = movie.title
        cell.setDelegate(delegate: self)
        cell.setSelectedMovie(movie: movie)
        cell.setUpLikeStatus(isFavorite: isFavoriteMovie(movie: movie))
        
        return cell
    }
    
    func configureSecondCell(movie: MoviesData, cell: SecondMovieDetailCell) -> SecondMovieDetailCell {
        cell.movieYear.text = formatData(movieDisplaying: movie.releaseDate)
        return cell
    }
    
    func configureThirCell(movie: MoviesData, cell: ThirdMovieDetailCell) -> ThirdMovieDetailCell {
        cell.movieGenre.text = getGenre(movie: movie)
        //cell.movieGenre.text = "\(movie.genreId)"
        return cell
    }
    
    func configureFourthCell(movie: MoviesData, cell: FourthMovieDetailCell) -> FourthMovieDetailCell {
        cell.movieDescription.text = movie.overview
        return cell
    }
    
    func getGenre(movie: MoviesData) -> String {
        var list = [String]()
        for j in 0..<genres.count {
            if movie.genreId.contains(genres[j].id) {
                list.append(genres[j].name)
            }
            
        }
            return list.joined(separator: ", ")
    }
}

extension MovieDetailViewModel: MovieListViewDelegate {
    func selectedMovie(movie: MoviesData) {
        saveMovie(movie: movie)
    }
    
    func unselectedMovie(movie: MoviesData) {
        deleteMovie(selectedMovie: movie)
    }
    
    
}





