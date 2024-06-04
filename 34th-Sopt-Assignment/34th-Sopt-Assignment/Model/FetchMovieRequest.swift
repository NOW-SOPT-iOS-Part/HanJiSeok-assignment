//
//  FetchMovieRequest.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 5/6/24.
//

import Foundation

struct FetchMovieRequest: Codable {
    let key: String
    let targetDt: String
    let repNationCd: String?

    init(
        key: String = Config.apiKey,
        targetDt: String = "20240505",
        repNationCd: String? = nil
    ) {
        self.key = key
        self.targetDt = targetDt
        self.repNationCd = repNationCd
    }
}
