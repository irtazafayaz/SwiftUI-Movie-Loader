//
//  MovieBackdropCarouselView.swift
//  TMDBSwiftUIApp
//
//  Created by Irtaza Fiaz on 23/06/2021.
//

import SwiftUI

struct MovieBackdropCarouselView: View {
    
    var title: String
    var moviesList: [Movie]
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16, content: {
                    ForEach(self.moviesList) { movie in
                        MovieBackdropCard(movie: movie)
                            .frame(width: 272, height: 200)
                            .padding(.leading, movie.id == self.moviesList.first!.id ? 16 : 0)
                            .padding(.trailing, movie.id == self.moviesList.last!.id ? 16 : 0)
                    }
                })
            }
        }
    }
}

struct MovieBackdropCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCarouselView(title: "Latest", moviesList: Movie.stubbedMovies)
    }
}
