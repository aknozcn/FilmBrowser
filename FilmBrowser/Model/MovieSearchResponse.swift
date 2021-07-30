//
//  MovieResponse.swift
//  FilmBrowser
//
//  Created by Akin O. on 27.07.2021.
//

import Foundation

struct MovieSearchResponse: Codable {
    let search: [MovieItem]?
    let totalResults: String?
    let response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults = "totalResults"
        case response = "Response"
    }
}

struct MovieItem: Codable {
    let title: String?
    let year: String?
    let imdbID: String?
    let type: String?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}
