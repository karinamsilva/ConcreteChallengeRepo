//
//  Constants.swift
//  ConcreteChallenge
//
//  Created by Karina on 18/07/22.
//

import UIKit

public struct Constants {
    
    static let apiKey: String = {
        guard
        let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
        let data = try? Data(contentsOf: url),
        let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String:Any],
        let key = plist["TMDB_API_KEY"] as? String
        else {
            fatalError("Failed to load API key")
        }
        return key
    }()
    
    static let title = "Movies"
    static let favoriteTitle = "Favorites"
    static let errorText = "Um erro ocorreu. Por favor, tente novamente."
    static let movieDetailScreen = "Movie"
    
    // MARK: - Icons
    
    static let listIcon = UIImage(named: "list_icon")
    static let favoriteIconEmpty = UIImage(named: "favorite_empty_icon")
    static let favoriteIconGray = UIImage(named: "favorite_gray_icon")
    static let favoriteIconFull = UIImage(named: "favorite_full_icon")
    static let errorImage = UIImage(named: "error_icon")
    static let searchImage = UIImage(named: "search_icon")
    
    static let collectionIdentifier = "MovieDetailCell"
    static let favoritesTableViewIdentifier = "FavoritesCell"
    static let firstMovieCell = "FirstMovieDetailCell"
    static let secondMovieCell = "SecondMovieDetailCell"
    static let thirdMovieCell = "ThirdMovieDetailCell"
    static let fourthMovieCell = "FourthMovieDetailCell"
}

struct Colors {
    static let yellow = UIColor(red: 247/255, green: 206/255, blue: 91/255, alpha: 1.0)
    static let gray = UIColor(red: 45/255, green: 48/255, blue: 71/255, alpha: 1.0)
    static let darkYellow = UIColor(red: 217/255, green: 151/255, blue: 30/255, alpha: 1.0)
}
