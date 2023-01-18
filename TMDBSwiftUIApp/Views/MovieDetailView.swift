//
//  MovieDetailView.swift
//  TMDBSwiftUIApp
//
//  Created by Irtaza Fiaz on 23/10/2021.
//

import SwiftUI

struct MovieDetailView: View {
    
    
    let movieId: Int
    @ObservedObject private var movieDetailState = MovieDetailState()
    
    var body: some View {
        
        ZStack () {
            LoadingView(isLoading: self.movieDetailState.isLoading, error: self.movieDetailState.error) {
                self.movieDetailState.loadMovie(id: self.movieId)
            }
            if movieDetailState.movie != nil {
                    MovieDetailListView(movie: self.movieDetailState.movie!)
            }
        }
        .navigationBarTitle(movieDetailState.movie?.title ?? "Error")
        .onAppear {
            self.movieDetailState.loadMovie(id: self.movieId)
        }
    }
}

struct MovieDetailListView: View {
    
    let movie: Movie
    
    var body: some View {
        List {
            MovieDetailImage(imageUrl: self.movie.backdropURL)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            HStack {
                Text(movie.genreText)
                Text("·")
                Text(movie.yearText)
                Text(movie.durationText)
            }
            Text(movie.overview)
            HStack {
                if !movie.ratingText.isEmpty {
                    Text(movie.ratingText).foregroundColor(.white)
                }
                Text(movie.scoreText)
            }
            
            Divider()
        }
        .listStyle(SidebarListStyle())
    }
    
}


struct MovieDetailImage: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    let imageUrl: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: imageUrl)
        }
    }
}


struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(movieId: Movie.stubbedMovie.id)
        } 
    }
}
