//
//  MovieModel.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 5/6/24.
//

import Foundation

struct MovieModel {
    let rank: String
    let name: String
    let amount: String
    let audience: String

    static func fetchMovie() async -> [MovieModel] {
        do {
            guard let movieService = try await MovieService.shared.fetch(request: FetchMovieRequest()) else {
                return []
            }
            return movieService
        } catch {
            return []
        }
    }
}
