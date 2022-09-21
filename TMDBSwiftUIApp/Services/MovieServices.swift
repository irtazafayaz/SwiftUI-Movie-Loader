//
//  MovieServices.swift
//  TMDBSwiftUIApp
//
//  Created by Irtaza Fiaz on 21/06/2021.
//

import Foundation

protocol MovieServices {
    
    func fetchMovies(from movieEndPoint: MovieListEndPoint, completion: @escaping (Result<MovieResponse,MovieError>) -> ())
    func fetchMovie(id: Int, completion: @escaping (Result<Movie,MovieError>) -> ())
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ())

}

enum MovieListEndPoint: String, CaseIterable, Identifiable {
    
    var id: String { rawValue }
    
    case nowPlaying = "now_playing"
    case upcoming
    case topRated = "top_rated"
    case popular
    
    var description: String {
        switch self {
            case .nowPlaying: return "Now Playing"
            case .upcoming: return "Upcoming"
            case .topRated: return "Top Rated"
            case .popular: return "Popular"
        }
    }
}



enum MovieError: Error, CustomNSError {
    
    case apiError
    case invalidEndPoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndPoint: return "Invlaid EndPoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
    
}
