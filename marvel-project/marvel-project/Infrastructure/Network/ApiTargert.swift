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
    
}, plugins: [NetworkLoggerPlugin(verbose: false)])

enum APITarget{
    case characters(offSet: Int)
    case charactersDetail(id: Int)
    case comics(id: Int, offSet: Int)
}

extension APITarget: TargetType {
    
    var path: String {
        switch  self {
        case .characters:
            return "/v1/public/characters"
        case .charactersDetail(let id):
            return "/v1/public/characters" + String(id)
        case .comics(let id):
            return"/v1/public/characters/\(id.id)/comics"
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
        case .characters(let offSet):
            var parameters: [String: Any] = [:]
            parameters[Keys.ts.rawValue] = Values.ts.rawValue
            parameters[Keys.apikey.rawValue] = Values.apikey.rawValue
            parameters[Keys.hash.rawValue] = Values.hash.rawValue
            parameters[Keys.orderBy.rawValue] = Values.orderByName.rawValue
            parameters[Keys.offset.rawValue] = offSet
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .charactersDetail:
            var parameters: [String: Any] = [:]
            parameters[Keys.ts.rawValue] = Values.ts.rawValue
            parameters[Keys.apikey.rawValue] = Values.apikey.rawValue
            parameters[Keys.hash.rawValue] = Values.hash.rawValue
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .comics(let offSet):
            var parameters: [String: Any] = [:]
            parameters[Keys.ts.rawValue] = Values.ts.rawValue
            parameters[Keys.apikey.rawValue] = Values.apikey.rawValue
            parameters[Keys.hash.rawValue] = Values.hash.rawValue
            parameters[Keys.offset.rawValue] = offSet.offSet
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}
