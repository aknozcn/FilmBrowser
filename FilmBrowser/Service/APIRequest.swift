//
//  APIRequest.swift
//  FilmBrowser
//
//  Created by Akin O. on 27.07.2021.
//

import Foundation
import Moya

enum APIConstants {
    public static let baseUrl = "https://www.omdbapi.com"
    public static let apiKey = "8b8ad4d3"
}

enum APIRequest {
    case getMovie(title: String)
    case getSearchMovie(searchText: String)
}

extension APIRequest: TargetType {

    var baseURL: URL {
        guard let url = URL(string: APIConstants.baseUrl) else { fatalError() }
        return url
    }

    var path: String {
        switch self {
        case .getMovie:
            return ""
        case .getSearchMovie:
            return ""
        }

    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getMovie(let title):
            let params = ["t": title, "apiKey": APIConstants.apiKey] as [String : Any]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .getSearchMovie(let searchText):
            let params = ["s": searchText, "apiKey": APIConstants.apiKey] as [String : Any]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
