//
//  HomeSceneInteractorTest.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Afaq Ahmad on 26/04/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import XCTest
@testable import The_Hitchhiker_Prophecy
class HomeSceneInteractorTest: XCTestCase {
  var sut:HomeSceneInteractor?
  private var expectation: XCTestExpectation!
  
  override func setUpWithError() throws {
    let presenter = HomeScenePresneter(displayView: self)
    let worker = HomeSearchWorker()
    sut = HomeSceneInteractor(worker: worker, presenter: presenter)
  }
  
  override func tearDownWithError() throws {
    sut = nil
    class MockInteractor: HomeSceneDataStore, HomeSceneBusinessLogic {
      var result: Characters.Search.Results?
      
      var worker: HomeWorkerType
      var presenter: HomeScenePresentationLogic
      
      var jsonFileName: String = ""
      
      func fetchCharacters() {
        guard let path = Bundle.main.path(forResource: jsonFileName, ofType: "json") else {
          self.presenter.presentCharacters(.failure(.cannotParseResponse))
          return
        }
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: path))
        if let data = try? JSONDecoder().decode(Characters.Search.Output.self, from: jsonData) {
          let response:HomeScene.Search.Response = .success(data)
          self.presenter.presentCharacters(response)
        }
        else {
          self.presenter.presentCharacters(.failure(.cannotParseResponse))
        }
      }
      
      init(worker: HomeWorkerType, presenter: HomeScenePresentationLogic) {
        self.worker = worker
        self.presenter = presenter
      }
    }
    
    class MockViewController: HomeSceneDisplayView {
      var interactor: HomeSceneBusinessLogic?
      var router: HomeSceneRoutingLogic?
      
      func didFetchCharacters(viewModel: [HomeScene.Search.ViewModel]) {
        guard viewModel.count > 0 else {
          XCTFail("Presenter failed to fulfill the task")
          return
        }
        
        XCTAssertTrue(viewModel.first?.name == "Hulk")
      }
      
      func failedToFetchCharacters(error: Error) {
        XCTAssertEqual(error as! NetworkError, NetworkError.cannotParseResponse)
      }
    }
    
  }
  
  func testHomeInteractorGetsValidData() {
    self.expectation = expectation(description: "Interactor gets the job done")
    sut?.fetchCharacters()
    wait(for: [self.expectation], timeout: 10)
    
    guard let results = sut?.result?.results else {
      XCTFail("Interactor failed to fulfill the task")
      return
    }
    
    XCTAssert(results.count > 0)
  }
}

extension HomeSceneInteractorTest: HomeSceneDisplayView {
  var interactor: HomeSceneBusinessLogic? { return sut }
  var router: HomeSceneRoutingLogic? { return nil}
  
  func didFetchCharacters(viewModel: [HomeScene.Search.ViewModel]) {
    self.expectation.fulfill()
  }
  
  func failedToFetchCharacters(error: Error) {
    self.expectation.fulfill()
  }
}
