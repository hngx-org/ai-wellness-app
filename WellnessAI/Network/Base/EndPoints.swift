//
//  EndPoints.swift
//  WellnessAI
//
//  Created by David OH on 01/10/2023.
//

import Foundation

enum EndPoint{
//        case create(submissionData: Data?)
    case detail(id: Int)
    case people(page: Int)
    case signIn(loginData: Data?)
    case signUp(data: Data?)
    case addBank(data: Data?)
}


extension EndPoint{
    var host: String{"BaseUrl"}
    
    var path: String{
        switch self{
        case .people,
                .signIn:
            return ""
        case .detail(id: let id):
            return "\(id)"
        case .signUp:
            return ""
        case .addBank:
            return ""
        }
    }
    
    enum MethodType{
        case get
        case post(data: Data?)
        case patch(data: Data?)
        case put(data: Data?)
        case delete(data: Data?)
    }
    
    var queryItems: [String: String]? {
        switch self{
        case .people(let page):
            return ["page":"\(page)"]
        default:
            return nil
        }
    }
    
    var methodType: MethodType{
        switch self {
        case .people,
                .detail:
            return .get
        case .signIn(let data):
            return .post(data: data)
        case .signUp(data: let data):
            return .post(data: data)
        case .addBank(data: let data):
            return .patch(data: data)
        }
    }
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        let requestQueryItems = queryItems?.compactMap { item in
            URLQueryItem(name: item.key, value: item.value)
        }
        urlComponents.queryItems = requestQueryItems
        return urlComponents.url
    }
}
