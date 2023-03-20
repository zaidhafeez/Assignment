//
//  TrendingPostViewModel.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import Foundation
import Combine

class TrendingPostViewModel {
    
    private var disposeBag = Set<AnyCancellable>()
    var post = Observable<TrendingPostResponse?>(value: nil)
    var trendingPost: PostList? {
        post.value?.data
    }
    
    
    func getTrendingPost() {
        trendingPostAPIRepository.getTrendingPost(request: TrendingPostRequest()).receive(on: DispatchQueue.main).sink {[weak self] error in
            print(error)
        } receiveValue: { [weak self] response in
            self?.post.value = response
        }.store(in: &disposeBag)
    }
    
}

extension TrendingPostViewModel: TrendingPostInjection {}
