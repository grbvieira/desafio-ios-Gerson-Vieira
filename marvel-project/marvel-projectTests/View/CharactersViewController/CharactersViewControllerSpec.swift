//
//  CharactersViewController.swift
//  marvel-projectTests
//
//  Created by Gerson Vieira on 11/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Quick
import Nimble
@testable import marvel_project

class CharactersViewControllerSpec: QuickSpec {
    
    override func spec() {
        var response: CharactersModel?
        let controller = CharactersViewController()
        beforeEach {
            response = Mock().getMockCharacters()
            controller.charactersResponse = .success([response!])
            
            describe("CharactersViewModelSpec") {
                
                context("fills array with wrapToViewModel function"){
                    it("characters should be greater than 0") {
                        expect(controller.viewModel.count > 0).to(beTrue())
                    }
                }
            }
        }
    }
}
