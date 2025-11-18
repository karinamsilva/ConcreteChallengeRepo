//
//  PersistenceManager.swift
//  ConcreteChallenge
//
//  Created by Karina on 07/03/23.
//

import Foundation

class PersistenceManager {
    
    private let moviesStore = UserDefaultsStore<MoviesData>(uniqueIdentifier: "moviesDataBase")
    
    func save(movie: MoviesData) {
        do {
            try moviesStore.save(movie)
        } catch {
            print("save movie error: \(movie.title)")
        }
    }
    
    func hasMovie(id: Int) -> Bool {
        return moviesStore.hasObject(withId: id)
    }
    
    func getAllMovies() -> [MoviesData] {
        return moviesStore.allObjects()
    }
    
    func deleteMovie(id: Int) {
        return moviesStore.delete(withId: id)
    }
    
    func deleteAllMovies() {
        moviesStore.deleteAll()
    }
    
    
    
    
}
