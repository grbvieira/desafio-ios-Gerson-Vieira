//
//  TargetType.swift
//  marvel-project
//
//  Created by Gerson Vieira on 03/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Moya

//enum ApiKey: String {
//    case publicKey = "b924601c14e330943c296e3f9a7df782"
//    case privateKey = "d7e39f6c60883f576dcd1f62f9e5da65b0800b02"
//}

enum Keys: String {
    case ts
    case apikey
    case hash
    case orderBy
    case offset
}

enum Values: String {
    case ts = "thesoer"
    case apikey = "b924601c14e330943c296e3f9a7df782"
    case hash = "9a1235588e7edc9f7aa1b9f040c4b71c"
    case orderByName = "name"
}

extension TargetType {
    
    public var baseURL: URL {
        return URL(string: "https://gateway.marvel.com:443")!
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String : String]? {
        return ["content-type": "application/json"]
    }
}
