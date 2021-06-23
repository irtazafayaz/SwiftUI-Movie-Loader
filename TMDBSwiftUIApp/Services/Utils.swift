//
//  Utils.swift
//  TMDBSwiftUIApp
//
//  Created by Irtaza Fiaz on 21/06/2021.
//

import Foundation


class Utils {
    
    static let jsonDecoder: JSONDecoder = {
       let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-mm-dd"
        return dateFormatter
    }()
}
