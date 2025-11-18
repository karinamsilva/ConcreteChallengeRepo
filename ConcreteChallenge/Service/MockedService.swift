//
//  MockedService.swift
//  ConcreteChallenge
//
//  Created by Karina on 07/03/23.
//

import Foundation

class MockedService: ServiceProtocol {
    func request(completion: @escaping (Result<[MoviesData], NetworkError>) -> Void) {
        let filePath = "movies"
        loadJsonFromFile(path: filePath) { data in
            if let json = data {
                do {
                    let movies = try JSONDecoder().decode(Movies.self, from: json)
                    completion(.success(movies.results))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }
    }
    
    func requestGenre(completion: @escaping (Result<[Genre], NetworkError>) -> Void) {
        let filePath = "Genre"
        loadJsonFromFile(path: filePath) { data in
            if let json = data {
                do {
                    let movieGenres = try JSONDecoder().decode(Genres.self, from: json)
                    completion(.success(movieGenres.genres))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }
    }
    
    private func loadJsonFromFile(path: String, completion: (Data?)-> Void) {
        if let fileUrl = Bundle.main.url(forResource: path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl, options: [])
                completion(data as Data)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
    
    
}
