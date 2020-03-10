//
//  CharactersProvider.swift
//  marvel-project
//
//  Created by Gerson Vieira on 07/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//


import Moya
import RxSwift

enum Request<T> {
    case none
    case loading
    case success(T)
    case failure(String)
}

protocol APIProtocol {
    func resquestCharacters(offSet: Int) -> Single<CharactersModel>
    func requestComics(id: Int) -> Single <ComicsModel>
}

class MarvelProjectProvider: APIProtocol {
    
    func resquestCharacters(offSet: Int) -> Single<CharactersModel> {
        return provider.rx
            .request(.characters(offSet: offSet))
            .map {
                let response = try JSONDecoder().decode(CharactersModel.self, from: $0.data)
                return response
        }
    }
    
    func requestComics(id: Int) -> Single<ComicsModel> {
        return provider.rx
            .request(.comics(id: id))
            .map {
                let response = try JSONDecoder().decode(ComicsModel.self, from: $0.data)
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
