//
//  MovieSearchViewModel.swift
//  FilmBrowser
//
//  Created by Akin O. on 29.07.2021.
//

import Foundation

protocol MovieSearchVMDelegate {
    func fetched(response: MovieSearchResponse)
}

class MovieSearchViewModel {
    
    private let apiManager = APIManager()

    var delegate: MovieSearchVMDelegate?
    
    func searchMovies(title: String) {
        apiManager.fetchSearchMovie(searchText: title) { (result) in
            switch result {
            case .success(let data):
                self.delegate?.fetched(response: data)
                print("success: \(data)")
            case .failure(let error):
                print("error searchMovies: \(error.localizedDescription)")
            }
        }
    }
}
