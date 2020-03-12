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
        
        
        describe("CharactersViewModelSpec") {
            
            context("fills array with wrapToViewModel function"){
                beforeEach {
                    response = Mock().getMockCharacters()
                    characters = FillViewModel().wrapToCharactersViewModel(model: response!)
                }
                it("characters should be greater than 0") {
                    expect(characters.count > 0).to(beTrue())
                }
                
                it("Shoul not be nil") {
                    expect(characters[0].id).notTo(beNil())
                }
                it("Shoul not be nil") {
                    expect(characters[0].description).notTo(beNil())
                }
                it("Shoul not be nil") {
                    expect(characters[0].name).notTo(beNil())
                }
                it("Shoul not be nil") {
                    expect(characters[0].thumbnail).notTo(beNil())
                }
                
                it("Shoul not be nil") {
                    expect(characters[0].id).to(equal(1011334))
                }
                it("Shoul not be nil") {
                    expect(characters[0].description).to(equal(""))
                }
                it("Shoul not be nil") {
                    expect(characters[0].name).to(equal("3-D Man"))
                }
                it("Shoul not be nil") {
                    let url = URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")!
                    expect(characters[0].thumbnail).to(equal(url))
                }
            }
        }
    }
}
