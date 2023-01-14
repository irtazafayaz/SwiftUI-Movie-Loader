//
//  ContentView.swift
//  TMDBSwiftUIApp
//
//  Created by Irtaza Fiaz on 21/06/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MovieDetailView(movieId: 550)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
