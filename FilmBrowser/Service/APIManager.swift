//
//  APIManager.swift
//  FilmBrowser
//
//  Created by Akin O. on 27.07.2021.
//

import Foundation
import Moya

class APIManager {

    var provider = MoyaProvider<APIRequest>(plugins: [NetworkLoggerPlugin()])

    func fetchMovie(title: String, completion: @escaping (Result<MovieResponse, Error>) -> ()) {
        request(target: .getMovie(title: title), completion: completion)
    }
    func fetchSearchMovie(searchText: String, completion: @escaping (Result<MovieSearchResponse, Error>) -> ()) {
        request(target: .getSearchMovie(searchText: searchText), completion: completion)
    }
    

    func request<T: Decodable>(target: APIRequest, completion: @escaping(Result<T, Error>) -> ()) {

        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
