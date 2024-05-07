//
//  APITarget+Movie.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 5/6/24.
//

import Foundation

import Moya

extension APITarget {
    enum Movie {
        case fetchMovie(FetchMovieRequest)
    }
}

extension APITarget.Movie: TargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchMovie(let fetchMovieRequest):
            return .requestParameters(
                parameters: [
                    "key": fetchMovieRequest.key,
                    "targetDt": fetchMovieRequest.targetDt
                ],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
