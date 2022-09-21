//
//  Movie.swift
//  TMDBSwiftUIApp
//
//  Created by Irtaza Fiaz on 21/06/2021.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Identifiable {
    
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
    let releaseDate: String?
    
    let genres: [MovieGenre]?
    
    
    static private let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    } ()
    
    static private let durationFormatter: DateComponentsFormatter = {
       let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .full
        return formatter
    }()
    
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var genreText: String {
        return genres?.first?.name ?? "n/a"
    }
    
    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "🌟"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }
    
    var yearText: String {
        guard let rDate = releaseDate, let date = Utils.dateFormatter.date(from: rDate) else {
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runtime = runtime, runtime > 0 else {
            return "n/a"
        }
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
    
    
    
    
}


struct MovieGenre : Decodable {
    let name: String
}
