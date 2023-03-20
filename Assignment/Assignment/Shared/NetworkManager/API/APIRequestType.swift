//
//  APIRequestType.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import Foundation

enum APIRequestType {
    case home
    
    var urlPath: String {
        HomeAPI.home
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .home:
            return .post
        }
    }
    
    func encodingBody() -> Bool {
        switch self {
        case .home:
            return true
        }
    }
    
    func URLEncoding() -> Bool {
        switch self {
        case .home:
            return false
        }
    }
    
    
}
