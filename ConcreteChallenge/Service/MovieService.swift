//
//  ApiRequest.swift
//  ConcreteChallenge
//
//  Created by Karina on 13/07/22.
//

import UIKit

protocol ServiceProtocol {
    func request(completion: @escaping (Result<[MoviesData], NetworkError>) -> Void)
    func requestGenre(completion: @escaping (Result<[Genre], NetworkError>) -> Void)
}

enum NetworkError: Error {
    case decodingError
    case network
}

class MovieService: ServiceProtocol {
    func request(completion: @escaping(Result<[MoviesData], NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(Constants.apiKey)") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(String(describing: error?.localizedDescription))
                completion(.failure(.network))
                return
            }
            do {
                let movies = try JSONDecoder().decode(Movies.self, from: data)
                completion(.success(movies.results))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func requestGenre(completion: @escaping (Result<[Genre], NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(Constants.apiKey)") else { return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.network))
                return
            }
            do {
                let movieGenres = try JSONDecoder().decode(Genres.self, from: data)
                completion(.success(movieGenres.genres))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
