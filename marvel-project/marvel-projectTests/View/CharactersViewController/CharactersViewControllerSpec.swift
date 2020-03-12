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
        describe("CharactersViewModelSpec") {
            context("Success request"){
                beforeEach {
                    controller.loadViewIfNeeded()
                    response = Mock().getMockCharacters()
                    controller.charactersResponse = .success([response!])
                }
                it("characters should be greater than 0") {
                    expect(controller.viewModel.count > 0).to(beTrue())
                }
                it("Should be equal 1") {
                    expect(controller.collectionView.numberOfSections).to(equal(1))
                }
                
                it("Should be equal 20") {
                    expect(controller.collectionView.numberOfItems(inSection: 0)).to(equal(60))
                }
            }
            
            context("Faile request"){
                beforeEach {
                    controller.viewModel = []
                    controller.loadViewIfNeeded()
                    controller.collectionView.reloadData()
                    controller.charactersResponse = .failure("Erro generico")
                }
                
                it("Should be equal 1") {
                    expect(controller.collectionView.numberOfSections).to(equal(1))
                }
                
                it("Should be equal 0") {
                    expect(controller.collectionView.numberOfItems(inSection: 0)).to(equal(0))
                }
                
                it("Should be equal ComicsCell") {
                    let index = IndexPath(row: 0, section: 0)
                    expect(controller.collectionView.cellForItem(at: index) is CharactersCell).to(beFalse())
                }
            }
        }
    }
}
