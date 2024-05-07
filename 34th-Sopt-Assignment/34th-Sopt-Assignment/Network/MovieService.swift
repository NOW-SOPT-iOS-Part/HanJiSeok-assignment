//
//  MovieService.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 5/6/24.
//

import Foundation

import Moya

final class MovieService {
    static let shared = MovieService()
    private var movieProvider = MoyaProvider<APITarget.Movie>(plugins: [MoyaLoggingPlugin()])
    private init() { }
}

extension MovieService {
    func fetch(
        request: FetchMovieRequest
    ) async throws -> [MovieModel]? {
        do {
            let request = await movieProvider.request(.fetchMovie(request))
            let statusCode = try request.get().statusCode
            let data = try request.get().data
            let networkResult = self.judgeStatus(statusCode, data, FetchMovieResponse.self)
            switch networkResult {
            case .success(let data):
                guard let data = data as? FetchMovieResponse else {
                    return nil
                }
                return data.boxOfficeResult.dailyBoxOfficeList.map { $0.entity }
            default:
                networkResult.statusDescription()
                return nil
            }
        } catch(let error) {
            print("@Log - \(error.localizedDescription)")
            return nil
        }
    }

    func fetch(
        request: FetchMovieRequest,
        completion: @escaping (NetworkResult<Any>) -> ()
    ) {
        movieProvider.request(.fetchMovie(request)) { [weak self] result in
            guard let self = self else { return
                completion(.networkFail)
            }
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(
                    statusCode,
                    data,
                    FetchMovieResponse.self)
                completion(.success(networkResult))
            case .failure:
                completion(.networkFail)
            }
        }
    }

    func judgeStatus<T: Codable>(
        _ statusCode: Int,
        _ data: Data,
        _ object: T.Type
    ) -> NetworkResult<Any> {
        switch statusCode {
        case 200..<205:
            return isVaildData(data, object)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }

    private func isVaildData<T: Codable>(
        _ data: Data,
        _ object: T.Type
    ) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(
            T.self,
            from: data
        ) else {
            print("⛔️ \(self)애서 디코딩 오류가 발생했습니다 ⛔️")
            return .pathErr
        }
        return .success(decodedData as Any)
    }
}
