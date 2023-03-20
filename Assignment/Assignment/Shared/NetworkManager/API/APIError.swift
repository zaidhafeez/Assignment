//
//  APIError.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import Foundation

enum APIError: Error, LocalizedError {
    case networkError(String, Int)
    case requestFailed(error: String)
    case decodingFailure(error: String)
    case unknownError

    public var errorDescription: String? {
        switch self {
        case let .networkError(error, _):
            return error
        case let .requestFailed(error: error):
            return error
        case let .decodingFailure(error: error):
            return error
        case .unknownError:
            return "Unknown Error"
            
        }
    }
}
