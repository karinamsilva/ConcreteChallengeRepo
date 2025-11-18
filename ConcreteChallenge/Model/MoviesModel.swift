import Foundation

// MARK: - Movies
struct Movies: Decodable {
    let results: [MoviesData]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
struct MoviesData: Codable, Identifiable {
    let genreId: [Int]
    let id: Int
    let overview: String
    let posterPath, title: String
    let releaseDate: String
    
    var posterImage: String {
        return "https://image.tmdb.org/t/p/w154\(posterPath)"
    }

    enum CodingKeys: String, CodingKey {
        case genreId = "genre_ids"
        case id
        case overview
        case posterPath = "poster_path"
        case title
        case releaseDate = "release_date"
    }
}
