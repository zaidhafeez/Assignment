//
//  BaseAPIClient.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import Foundation
import Combine

class BaseAPIClient {
    
    func fetch<T: Codable>(request: URLRequest) -> AnyPublisher<T, APIError> {
        //Log Request
        print("[\(request.httpMethod?.uppercased() ?? "")] '\(request.url!)'")
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
            .dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            // Map on Request response
            .tryMap({ data, response in
                
                // If the response is invalid, throw an error
                guard let response = response as? HTTPURLResponse else {
                    throw APIError.unknownError
                }
                
                //Log Request result
                print("[\(response.statusCode)] '\(request.url!)'")
                
                if !(200...299).contains(response.statusCode) {
                    throw APIError.requestFailed(error: "\(response.statusCode)")
                }
                // Return Response data
                print(String(data: data, encoding: .utf8))
                return data
            })
            .receive(on: DispatchQueue.main)
            // Decode data using our ReturnType
            .decode(type: T.self, decoder: JSONDecoder())
            // Handle any decoding errors
            .mapError { error in
                return APIError.decodingFailure(error: error.localizedDescription)
            }
            // And finally, expose our publisher
            .eraseToAnyPublisher()
    }
}
