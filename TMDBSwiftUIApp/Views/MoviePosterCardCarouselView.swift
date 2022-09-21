//
//  MoviePosterCardCarouselView.swift
//  TMDBSwiftUIApp
//
//  Created by Irtaza Fiaz on 23/06/2021.
//

import SwiftUI

struct MoviePosterCardCarouselView: View {
    
    var title: String
    var movies: [Movie]
    
    
    var body: some View {
        VStack (alignment: .leading, spacing: 16, content: {
            Text(self.title)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.horizontal)
            
            ScrollView (.horizontal, showsIndicators: false, content: {
                HStack(alignment: .top, spacing: 16, content: {
                    ForEach(self.movies) { movie in
                        MoviePosterCard(movie: movie)
                            .padding(.leading, movie.id == self.movies.first?.id ? 16 : 0)
                            .padding(.trailing, movie.id == self.movies.last?.id ? 16 : 0)
                    }
                })
            })
        })
    }
}

struct MoviePosterCardCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCardCarouselView(title: "Now Playing", movies: Movie.stubbedMovies)
    }
}
