//
//  MoviesListControllerSpec.swift
//  movie-listTests
//
//  Created by Marcellus Selga Batista on 02/12/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import UIKit
@testable import movie_list

class MoviesListControllerSpec: QuickSpec {
    
    var sut: MoviesListController!
    
    override func spec() {
        describe("Movie list") {
            context("load first page") {
                beforeEach {
                    self.sut = R.storyboard.main.moviesListController()
                    
                    WindowHelper.showInTestWindow(viewController: self.sut)
                    self.sut.view.frame = CGRect(x: 0, y: 0, width: 320, height: 680)
                }
                
                it("has valid snapshot") {
                    expect(self.sut.view).toEventually(haveValidSnapshot()) // not ready yet
                }
            }
        }
    }
}
