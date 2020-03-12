//
//  ComicsViewControllerSpec.swift
//  marvel-projectTests
//
//  Created by Gerson Vieira on 11/03/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Quick
import Nimble
@testable import marvel_project

class ComicsViewControllerSpec: QuickSpec {
    
    override func spec() {
        var response: ComicsModel?
        let controller = ComicsViewController(id: 0)
        describe("ComicsViewModeSpec") {
            context("Success request"){
                beforeEach {
                    response = Mock().getMockComics()
                    controller.loadViewIfNeeded()
                    controller.comicsResponse = .success([response!])
                }
                
                it("Should be equal 1") {
                    expect(controller.tableView.numberOfSections).to(equal(1))
                }
                
                it("Should be equal 20") {
                    expect(controller.tableView.numberOfRows(inSection: 0)).to(equal(20))
                }
                
                it("Should be equal ComicsCell") {
                    let index = IndexPath(row: 0, section: 0)
                    expect(controller.tableView.cellForRow(at: index) is ComicsCell).to(beTrue())
                }
            }
            
            context("Faile request"){
                beforeEach {
                    controller.viewModel = []
                    controller.loadViewIfNeeded()
                    controller.reloadData()
                    controller.comicsResponse = .failure("Erro generico")
                }
                
                it("Should be equal 1") {
                    expect(controller.tableView.numberOfSections).to(equal(1))
                }
                
                it("Should be equal 0") {
                    expect(controller.tableView.numberOfRows(inSection: 0)).to(equal(0))
                }
                
                it("Should be equal ComicsCell") {
                    let index = IndexPath(row: 0, section: 0)
                    expect(controller.tableView.cellForRow(at: index) is ComicsCell).to(beFalse())
                }
            }
        }
    }
}
