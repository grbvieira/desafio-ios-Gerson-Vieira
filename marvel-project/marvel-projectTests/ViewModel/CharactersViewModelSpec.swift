//
//  CharactersViewModel.swift
//  marvel-projectTests
//
//  Created by Gerson Vieira on 11/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Quick
import Nimble
@testable import marvel_project

class CharactersViewModelSpec: QuickSpec {
    
    override func spec() {
        var characters: [CharactersViewModel] = []
        var response: CharactersModel?
        
        beforeEach {
            response = Mock().getMockCharacters()
            characters = FillViewModel().wrapToCharactersViewModel(model: response!)
            
            describe("CharactersViewModelSpec") {
                
                context("fills array with wrapToViewModel function"){
                    it("characters should be greater than 0") {
                        expect(characters.count > 0).to(beTrue())
                    }
                }
            }
        }
    }
}
