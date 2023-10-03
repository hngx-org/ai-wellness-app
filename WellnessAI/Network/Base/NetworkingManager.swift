//
//  NetworkingManager.swift
//  WellnessAI
//
//  Created by David OH on 01/10/2023.
//

import Foundation

class NetworkingManager {
    
    static let shared = NetworkingManager()
    private init(){
        
    }
    func request<T: Codable>(endpoint: EndPoint, type: T.Type) async throws  -> T{
        
        guard let url = endpoint.url else{
            throw NetworkingError.invalidUrl
        }
        let request = buildRequest(url: url, methodtype: endpoint.methodType)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
          //            let statusCode = (response as! HTTPURLResponse).statusCode
          //            throw NetworkingError.invalidStatusCode(statusCode: statusCode )
          guard let response = response as? HTTPURLResponse,
                (400...500) ~= response.statusCode else {
              let statusCode = (response as! HTTPURLResponse).statusCode
              throw NetworkingError.invalidStatusCode(statusCode: statusCode )
          }
          let decoder = JSONDecoder()
          decoder.keyDecodingStrategy = .useDefaultKeys
          let res = try decoder.decode(ErrorResponseModel.self , from: data)
            throw NetworkingError.customError(error: res.message)
        }
        /// Adding cookies to storage
        let cookieProperties: [HTTPCookiePropertyKey: Any] = [
            .name: response.value(forHTTPHeaderField: "name") ?? "session",
            .value: response.value(forHTTPHeaderField: "value") ?? "82946269-e696-4abb-884c-5b8995e9bc83.pSs_Fl9zlKdhAlKYr7laXmecbxA",
            .domain: response.value(forHTTPHeaderField: "domain") ?? "spitfire-interractions.onrender.com",
            .path: "/",
            // Add other properties as needed
        ]

        if let cookie = HTTPCookie(properties: cookieProperties) {
            // Add the cookie to shared storage
            HTTPCookieStorage.shared.setCookie(cookie)
//            print("See cookies to store \(cookie)")
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        let res = try decoder.decode(T.self , from: data)
        return res
        
    }
    
    func request(endpoint: EndPoint) async throws {
        
        guard let url = endpoint.url else{
            throw NetworkingError.invalidUrl
        }
        
        let request = buildRequest(url: url, methodtype: endpoint.methodType)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        dump(String(data:request.httpBody!,encoding: .utf8))
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode )
        }
    }
    
    
}


extension NetworkingManager {
    enum NetworkingError: LocalizedError{
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error : Error)
        case customError(error: String)
        
        var errorDescription: String?{
            switch self{
            case .invalidUrl:
                return "Url not valid"
            case .invalidStatusCode:
                return  "Invalid status code"
            case .invalidData:
                return  "Response data is invalid"
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(error: let error):
                return "Something went wrong \(error.localizedDescription)"
            case .customError(error: let error):
                return error
            }
        }
    }
    
    
    func buildRequest (url: URL, methodtype: EndPoint.MethodType) -> URLRequest{
        var request = URLRequest(url: url)
        switch methodtype{
        case .get:
            request.httpMethod = "Get"
        case .post(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        case .put(let data):
            request.httpMethod = "PUT"
            request.httpBody = data
        case .delete(let data):
            request.httpMethod = "DELETE"
            request.httpBody = data
        case .patch(data: let data):
            request.httpMethod = "PATCH"
            request.httpBody = data
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        /// Accessing cookies from storage
        guard let cookies = HTTPCookieStorage.shared.cookies(for: url) else {
            print("here with no cookies")
            return request
        }
//        print("see cookies \(cookies)")
        request.allHTTPHeaderFields = HTTPCookie.requestHeaderFields(with: cookies)
        
        return request
    }
}

// MARK: - ErrorResponseModel
struct ErrorResponseModel: Codable {
    let error: String?
    let message: String
}

