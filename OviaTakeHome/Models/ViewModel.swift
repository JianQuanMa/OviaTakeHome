//
//  ViewModel.swift
//  OviaTakeHome
//
//  Created by Jian Ma on 3/6/22.
//

import Foundation

// MARK: - search
struct SearchData: Codable {
    let search: [Search]
    let totalResults, response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Search
struct Search: Codable {
    let title, year, imdbID: String?
    let type: TypeEnum
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
}

// rating data
struct RatingData: Codable {
    let imdbRating: String
}

