//
//  MovieStore.swift
//  TMDBSwiftUIApp
//
//  Created by Irtaza Fiaz on 21/06/2021.
//

import Foundation


class MovieStore: MovieServices {
    
    //MARK: Implemention Singleton Class Pattern
    private init (){}
    static let shared = MovieStore()
    
    private let apiKey = "870fea2ca635981ef59ec080f30ef0be"
    private let baseAPIUrl = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    
    
    func fetchMovies(from movieEndPoint: MovieListEndPoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIUrl)/movie/\(movieEndPoint.rawValue)") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLandDeconde(url: url, completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        print(id)
        guard let url = URL(string: "\(baseAPIUrl)/movie/550") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLandDeconde(url: url, params: [
            "append_to_response": "videos,credits"
        ], completion: completion)
    }
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIUrl)/search/movie") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLandDeconde(url: url, params: [
            "language": "en-US",
            "include_adult": "false",
            "region": "US",
            "query": query
        ], completion: completion)
    }
    
    func loadURLandDeconde<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, MovieError>) -> ()) {
        guard var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map{ URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponent.queryItems = queryItems
        
        guard let finalUrl = urlComponent.url else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        urlSession.dataTask(with: finalUrl) { [weak self] (data, response, error) in
            
            guard let self = self else { return }
            
            if let _ = error {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
                
            } catch let error {
                print(error)
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
 
        }.resume()
  
    }
    
    func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, MovieError>, completion: @escaping (Result<D, MovieError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
    
    
    
}
