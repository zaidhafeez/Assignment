//
//  AppNetworkManager.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import Foundation
import Combine

protocol NetworkManagerInjection {}
extension NetworkManagerInjection {
    var networkManager: AppNetworkProtocol {
        return AppDependencyInjection.networkManager
    }
}

public typealias AppParameters = [String: Any]

protocol AppNetworkProtocol {
    func loadRequest<T>(requestType: APIRequestType, param: AppParameters?) -> AnyPublisher<T, APIError> where T: Codable
}

extension AppNetworkProtocol {
    func loadRequest<T>(requestType: APIRequestType) -> AnyPublisher<T, APIError> where T: Codable {
        loadRequest(requestType: requestType, param: nil)
    }
}

class AppNetworkManager: BaseAPIClient, AppNetworkProtocol {
    
    static let shared = AppNetworkManager()
    
    func loadRequest<T>(requestType: APIRequestType, param: AppParameters? = nil) -> AnyPublisher<T, APIError>  where T : Decodable, T : Encodable {
        
        
        let apiRequest = AppAPIRequest(requestType: requestType, param: param)
        
        let urlRequest = asURLRequest(request: apiRequest)
        
        guard let urlRequest = urlRequest else {
            return Fail(outputType: T.self, failure: APIError.requestFailed(error: "Bad Request")).eraseToAnyPublisher()
        }
        
        typealias RequestPublisher = AnyPublisher<T, APIError>
        
        let requestPublisher: RequestPublisher = fetch(request: urlRequest)
        return requestPublisher.eraseToAnyPublisher()
    }
    
    
    private func asURLRequest(request: AppAPIRequest) -> URLRequest? {
        
        guard var urlComponents = URLComponents(string: request.urlPath()) else { return nil }
        
        if request.URLEncoding() {
            urlComponents.queryItems = request.addQueryItems(queryParams: request.parameters())
        }
        
        guard let finalURL = urlComponents.url else { return nil }
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = request.httpMethod().rawValue
        urlRequest.allHTTPHeaderFields = request.headers()
        if request.encodingBody() {
            urlRequest.httpBody = request.requestBodyFrom(params: request.parameters())
        }
        
        ///Set your Common Headers here
        ///Like: api secret key for authorization header
        ///Or set your content type
        urlRequest.setValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMTA0N2NjODktMzg5Zi00NzgxLWE5MGYtZTRkYTA1MDMxNmYzIiwicGhvbmUiOiI5ODk5MjkyODM4IiwiZXhwIjoxNjgxNDk1NDEzfQ.VJPlRLqavEg2OK4l-l5tcDgbiwVNKF1GNKEoDFCjuWw", forHTTPHeaderField: RequestConstants.Token)
        urlRequest.setValue(RequestConstants.ContentValue, forHTTPHeaderField: RequestConstants.ContentType)
      
        return urlRequest
    }
    
    
}
