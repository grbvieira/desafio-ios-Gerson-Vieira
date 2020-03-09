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
    func resquestCharacters(offSet: Int) -> Single<CharactersModel>
}
class CharactersProvider: APIProtocol {
    
    func resquestCharacters(offSet: Int) -> Single<CharactersModel> {
        return provider.rx
            .request(.characters(offSet: offSet))
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
