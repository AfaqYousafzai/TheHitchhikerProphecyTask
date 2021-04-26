//
//  HomeScenePresenter.swift
//  The Hitchhiker Prophecy
//
//  Created by Mohamed Matloub on 6/13/20.
//  Copyright © 2020 SWVL. All rights reserved.
//

import Foundation

class HomeScenePresneter: HomeScenePresentationLogic {
    weak var displayView: HomeSceneDisplayView?
    
    init(displayView: HomeSceneDisplayView) {
        self.displayView = displayView
    }
    
    func presentCharacters(_ response: HomeScene.Search.Response) {
      // TODO: Implement
      
      // The list of characters will be generated and sen to displayview based on the response.
      var characterViewModel = [HomeScene.Search.ViewModel]()
      switch response {
      case .success(let marvelCollection):
        for marvelCharacter in marvelCollection.data.results {
          // Image path with ddition to extension to be used later for loading images
          let thumbnail = "\(marvelCharacter.thumbnail.path).\(marvelCharacter.thumbnail.thumbnailExtension)"
          let model = HomeScene.Search.ViewModel(name: marvelCharacter.name, desc: marvelCharacter.resultDescription, imageUrl: thumbnail, comics: "", series: "", stories: "", events: "")
          characterViewModel.append(model)
        }
        // call displayView success scenrio implemented by controller
        self.displayView?.didFetchCharacters(viewModel: characterViewModel)
      case .failure(let erorr):
        // call displayView failure scenrio implemented by controller
        self.displayView?.failedToFetchCharacters(error: erorr)
      }
    }
}
