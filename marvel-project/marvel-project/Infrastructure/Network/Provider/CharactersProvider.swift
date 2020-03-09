//
//  CharactersProvider.swift
//  marvel-project
//
//  Created by Gerson Vieira on 07/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//


import Moya
import RxSwift

protocol APIProtocol {
    func resquestCharacters() -> Single<CharactersModel>
}
class CharactersProvider: APIProtocol {
    
    func resquestCharacters() -> Single<CharactersModel> {
        return provider.rx
            .request(.characters)
            .map {
                let response = try JSONDecoder().decode(CharactersModel.self, from: $0.data)
                return response
        }
    }
}
extension Data
{
    func printJSON()
    {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8)
        {
            print(JSONString)
        }
    }
}
