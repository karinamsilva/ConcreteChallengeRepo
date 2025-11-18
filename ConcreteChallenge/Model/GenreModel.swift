//
//  GenreModel.swift
//  ConcreteChallenge
//
//  Created by Karina on 07/03/23.
//

import Foundation

struct Genres: Codable {
    let genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
}

struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}
