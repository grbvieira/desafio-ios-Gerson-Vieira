//
//  ApiTargert.swift
//  marvel-project
//
//  Created by Gerson Vieira on 03/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Moya

let provider = MoyaProvider<APITarget>( endpointClosure: { (target) -> Endpoint in
    
    return Endpoint(url: "\(target.baseURL)\(target.path)",
        sampleResponseClosure: {.networkResponse(200, target.sampleData)},
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers)
    
}, plugins: [NetworkLoggerPlugin(verbose: true)])

enum APITarget{
    case characters
    case charactersDetail(id: Int)
    case comics(id: Int)///v1/public/characters/{characterId}/comics
}

extension APITarget: TargetType {
    
    var path: String {
        switch  self {
        case .characters:
            return Paths.characters.rawValue
        case .charactersDetail(let id):
            return Paths.characters.rawValue + String(id)
        case .comics(let id):
            return Paths.comics.rawValue + String(id)
        }
    }
    
    var method: Method {
        switch self {
        case .characters: return .get
        case .charactersDetail: return .get
        case .comics: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .characters:
            var parameters: [String: Any] = [:]
            parameters[Keys.ts.rawValue] = Values.ts.rawValue
            parameters[Keys.apikey.rawValue] = Values.apikey.rawValue
            parameters[Keys.hash.rawValue] = Values.hash.rawValue
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .charactersDetail:
            var parameters: [String: Any] = [:]
            parameters[Keys.ts.rawValue] = Values.ts.rawValue
            parameters[Keys.apikey.rawValue] = Values.apikey.rawValue
            parameters[Keys.hash.rawValue] = Values.hash.rawValue
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .comics:
            var parameters: [String: Any] = [:]
            parameters[Keys.ts.rawValue] = Values.ts.rawValue
            parameters[Keys.apikey.rawValue] = Values.apikey.rawValue
            parameters[Keys.hash.rawValue] = Values.hash.rawValue
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}
