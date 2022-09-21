//
//  MovieDetailState.swift
//  TMDBSwiftUIApp
//
//  Created by Irtaza Fiaz on 05/08/2021.
//

import Foundation

class MovieDetailState: ObservableObject {
    
    private let movieService: MovieServices
    @Published var movie: Movie?
    @Published var error: NSError?
    @Published var isLoading = false
    
    init(movieService: MovieServices = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func loadMovie(id: Int) {
        
        movie = nil
        isLoading = false
        self.movieService.fetchMovie(id: 550) {[weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                self.error = error as NSError
            }
        }
        
    }
    
    
}
