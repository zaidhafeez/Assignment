//
//  TrendingPostUseCase.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import Foundation
import Combine

protocol TrendingPostInjection {}
extension TrendingPostInjection {
    var trendingPostAPIRepository: TrendingPostAPIRepositoryProtocol {
        return AppDependencyInjection.trendingPost
    }
}

protocol TrendingPostAPIRepositoryProtocol {
    func getTrendingPost(request: TrendingPostRequest) -> AnyPublisher<TrendingPostResponse, APIError>
}

struct TrendingPostUseCase: TrendingPostAPIRepositoryProtocol {
    func getTrendingPost(request: TrendingPostRequest) -> AnyPublisher<TrendingPostResponse, APIError> {
        let future: AnyPublisher<TrendingPostResponse, APIError> = networkManager.loadRequest(requestType: .home, param: request.asDictionary)
        return future.eraseToAnyPublisher()
    }
}

extension TrendingPostUseCase: NetworkManagerInjection {}
