//
//  HomeScenePresenterTest.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Afaq Ahmad on 26/04/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import XCTest
@testable import The_Hitchhiker_Prophecy

class HomeScenePresenterTest: XCTestCase {

  var displayView: HomeSceneDisplayView?
  var mockInteractor:MockInteractor?

  override func setUpWithError() throws {
      displayView = MockViewController()
      let presenter = HomeScenePresneter(displayView: displayView!)
      let worker = HomeSearchWorker()
      mockInteractor = MockInteractor(worker: worker, presenter: presenter)
  }

  override func tearDownWithError() throws {
      displayView = nil
      mockInteractor = nil
  }
  
  func testPresenterPassDataToControllerWithValidViewModels() {
      mockInteractor?.jsonFileName = "jsonFileName"
      mockInteractor?.fetchCharacters()
  }
  
  func testPresenterWithInvalidResponseFiletoTestFailCase() {
      mockInteractor?.jsonFileName = "some_invalid_name"
      mockInteractor?.fetchCharacters()
  }
}

class MockInteractor: HomeSceneDataStore, HomeSceneBusinessLogic {
  var result: Characters.Search.Results?
  
  var worker: HomeWorkerType
  var presenter: HomeScenePresentationLogic
  
  var jsonFileName:String = ""
  
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
          XCTFail("Presenter unable to setup valid view models")
          return
      }
      
      XCTAssertTrue(viewModel.first?.name == "Hulk")
  }
  
  func failedToFetchCharacters(error: Error) {
      XCTAssertEqual(error as! NetworkError, NetworkError.cannotParseResponse)
  }
}
