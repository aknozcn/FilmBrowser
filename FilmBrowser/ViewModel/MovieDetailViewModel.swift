//
//  MovieDetailViewModel.swift
//  FilmBrowser
//
//  Created by Akin O. on 29.07.2021.
//

import Foundation

protocol MovieDetailVMDelegate {
    func fetched(response: MovieResponse)
}

class MovieDetailViewModel {
    
    private let apiManager = APIManager()

    var delegate: MovieDetailVMDelegate?
    
    func getMovie(title: String) {
        apiManager.fetchMovie(title: title) { (result) in
            switch result {
            case .success(let data):
                self.delegate?.fetched(response: data)
                print("success: \(data)")
            case .failure(let error):
                print("error getMovie: \(error.localizedDescription)")
            }
        }
    }
}

