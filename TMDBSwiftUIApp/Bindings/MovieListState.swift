//
//  MovieListState.swift
//  TMDBSwiftUIApp
//
//  Created by Irtaza Fiaz on 12/07/2021.
//

import SwiftUI

class MovieListState: ObservableObject {
    
    @Published var movies: [Movie]?
    @Published var isLoading = false
    @Published var error: NSError?
    
    private let movieService: MovieServices
    
    init(movieService: MovieServices = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func loadMovies(with endPoint: MovieListEndPoint) {
        self.movies = nil
        self.isLoading = false
        self.movieService.fetchMovies(from: endPoint) { [weak self] (result) in
            
            guard let _ = self else { return }
            self?.isLoading = false
            switch(result) {
            case .success(let response):
                self?.movies = response.results
            case .failure(let error):
                self?.error = error as NSError
            }
            
        }  
    }
    
    
}
