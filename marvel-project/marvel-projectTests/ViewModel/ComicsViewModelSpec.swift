//
//  ComicsViewModel.swift
//  marvel-projectTests
//
//  Created by Gerson Vieira on 11/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Quick
import Nimble
@testable import marvel_project

class ComicsViewModeSpec: QuickSpec {
    
    override func spec() {
        var comics: [ComicsViewModel] = []
        var response: ComicsModel?
        
        beforeEach {
            response = Mock().getMockComics()
            comics = FillViewModel().wrapToComicsViewModel(model: response!)
            
            describe("ComicsViewModeSpec") {
                
                context("fills array with wrapToViewModel function"){
                    it("comics should be greater than zero") {
                        expect(comics.count > 0).to(beTrue())
                    }
                }
            }
        }
    }
}
