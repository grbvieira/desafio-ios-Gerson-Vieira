//
//  Mock.swift
//  marvel-projectTests
//
//  Created by Gerson Vieira on 11/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
@testable import marvel_project

class Mock {
    func getMockCharacters() -> CharactersModel?{
        if let path = Bundle.main.path(forResource: "CharacterMock", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let response = try  JSONDecoder().decode(CharactersModel.self, from: data)
                return response
            } catch {
                fatalError("Não foi possivel ler o json")
            }
        }
        return nil
    }
    
    func getMockComics() -> ComicsModel?{
           if let path = Bundle.main.path(forResource: "ComicsMock", ofType: "json") {
               do {
                   let fileUrl = URL(fileURLWithPath: path)
                   let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                   let response = try  JSONDecoder().decode(ComicsModel.self, from: data)
                   return response
               } catch {
                   fatalError("Não foi possivel ler o json")
               }
           }
           return nil
       }
}
