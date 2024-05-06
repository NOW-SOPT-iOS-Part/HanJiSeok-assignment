//
//  FetchMovieResponse.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 5/6/24.
//

import Foundation

struct FetchMovieResponse: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [Movie]
}

extension BoxOfficeResult {
    struct Movie: Codable {
        /// 순번
        let rnum: String
        /// 박스오피스 순위
        let rank: String
        /// 전일대비 순위 증감분
        let rankInten: String
        /// 랭킹 신규 진입 여부
        let rankOldAndNew: String
        /// 영화 대표 코드
        let movieCd: String
        /// 영화명(국문)
        let movieNm: String
        /// 영화 개봉일
        let openDt: String
        /// 영화 매출액
        let salesAmt: String
        /// 매출 총액 대비 영화의 매출 비율
        let salesShare: String
        /// 전일 대비 매출액 증감분
        let salesInten: String
        /// 전일 대비 매출액 증감 비율
        let salesChange: String
        /// 누적매출액
        let salesAcc: String
        /// 해당 일의 관객수 출력
        let audiCnt: String
        /// 전일 대비 관객수 증감분
        let audiInten: String
        /// 전일 대비 관객수 증감 비율
        let audiChange: String
        /// 누적 관객수
        let audiAcc: String
        /// 해당 일자에 상영한 스크린 수 출력
        let scrnCnt: String
        /// 해당 일자에 상영된 횟수
        let showCnt: String

        var entity: MovieModel {
            MovieModel(
                rank: self.rank,
                name: self.movieNm,
                amount: self.salesAcc,
                audience: self.audiAcc
            )
        }
    }
}
