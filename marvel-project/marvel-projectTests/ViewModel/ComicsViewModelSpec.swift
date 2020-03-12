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
        
        describe("ComicsViewModeSpec") {
            
            context("fills array with wrapToViewModel function"){
                beforeEach {
                    response = Mock().getMockComics()
                    comics = FillViewModel().wrapToComicsViewModel(model: response!)
                }
                it("comics should be greater than zero") {
                    expect(comics.count > 0).to(beTrue())
                }
                
                it("Shoul not be nil") {
                    expect(comics[0].issue).notTo(beNil())
                }
                it("Shoul not be nil") {
                    expect(comics[0].onsaleDate).notTo(beNil())
                }
                it("Shoul not be nil") {
                    expect(comics[0].thumbnail).notTo(beNil())
                }
                it("Shoul not be nil") {
                    expect(comics[0].title).notTo(beNil())
                }
                
                it("Shoul not be nil") {
                    expect(comics[0].issue).to(equal("Issue #\(25)"))
                }
                it("Shoul not be nil") {
                    expect(comics[0].onsaleDate).to(equal("sale date: September 1, 2004"))
                }
                it("Shoul not be nil") {
                    expect(comics[0].title).to(equal("Captain Marvel (2002) #25"))
                }
                it("Shoul not be nil") {
                    let url = URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/5/b0/5b228d60f123a.jpg")!
                    expect(comics[0].thumbnail).to(equal(url))
                }
            }
        }
    }
}
