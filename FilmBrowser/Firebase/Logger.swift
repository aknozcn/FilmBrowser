//
//  Logger.swift
//  FilmBrowser
//
//  Created by Akin O. on 29.07.2021.
//

import Foundation
import FirebaseAnalytics

class Logger {

    static func LogIt(movie: MovieResponse){
        let param: [String: Any] = ["title": movie.title ?? "", "poster": movie.poster ?? "", "type": movie.type ?? "", "date": movie.year ?? ""]
        Analytics.logEvent("movieDetails", parameters: param)
    }
}
