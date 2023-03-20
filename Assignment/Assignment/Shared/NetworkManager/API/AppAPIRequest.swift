//
//  AppAPIRequest.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import Foundation

enum HTTPMethod: String {
    case get       = "GET"
    case post      = "POST"
    case put       = "PUT"
    case delete    = "DELETE"
}

struct RequestConstants {
    static let RequestType = "X-Requested-With"
    static let RequestValue = "XMLHttpRequest"
    
    static let ContentType = "Content-Type"
    static let ContentValue = "application/json"
    static let ContentValuePlain = "text/plain"
    static let AcceptEncodingValue = "gzip, deflate, br"
    static let AcceptEncoding      = "Accept-Encoding"
    static let AcceptField         = "Accept"
    static let AcceptFieldValue    = "*/*"
    static let ConnectionField     = "Connection"
    static let ConnectionFieldValue     = "keep-alive"

    static let ContentLengthField = "Content-Length"
    
    static let Authorization = "Authorization"
    static let MultiPartValue = "multipart/form-data"
    static let Bearer = "Bearer"
    static let multiPartValue = "multipart/form-data"
    static let errorCode = "statusCode"
    static let requestTimeOut = "Request time out"
    static let sessionToken = "x-session-token"
    static let Token = "Token"
}

struct AppAPIRequest {
    
    private let requestType: APIRequestType
    private var param: AppParameters?  = nil

    init(requestType: APIRequestType, param: AppParameters?  = nil) {
        self.requestType = requestType
        self.param = param
    }
    
    func apiRequestType() -> APIRequestType {
        return requestType
    }
    
    func parameters() -> AppParameters?  {
        return param
    }
    
    func encodingBody() -> Bool {
        return requestType.encodingBody()
    }
    
    func URLEncoding() -> Bool {
        return requestType.URLEncoding()
    }
        
    func httpMethod() -> HTTPMethod {
        return requestType.httpMethod
    }
    
    func headers() -> [String : String]? {
        let headers: [String : String]? = defaultHeaders()
        return headers
    }
    
    func urlPath() -> String {
        return appConfiguration.baseUrl + requestType.urlPath
    }
    
    func defaultHeaders() -> [String : String]? {
        let headers: [String : String]? = [RequestConstants.ContentType: RequestConstants.ContentValue,
                                    RequestConstants.AcceptEncoding:RequestConstants.AcceptEncodingValue,
                                    RequestConstants.AcceptField: RequestConstants.AcceptFieldValue,
                                    RequestConstants.ConnectionField: RequestConstants.ConnectionFieldValue]
        
        return headers
    }
    
    func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        return httpBody
    }
    
    func addQueryItems(queryParams: AppParameters?) -> [URLQueryItem]? {
        guard let queryParams = queryParams else {
            return nil
        }
        return queryParams.map({URLQueryItem(name: $0.key, value: "\($0.value)")})
    }
}

extension AppAPIRequest: ConfigurationInjection {}
