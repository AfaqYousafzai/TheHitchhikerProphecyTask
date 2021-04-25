//
//  HomeSceneViewController.swift
//  The Hitchhiker Prophecy
//
//  Created by Mohamed Matloub on 6/10/20.
//  Copyright © 2020 SWVL. All rights reserved.
//

import UIKit

class HomeSceneViewController: UIViewController {
  
  // MARK: - Properties
  @IBOutlet weak var charactersList: UICollectionView!
    
    var interactor: HomeSceneBusinessLogic?
    var router: HomeSceneRoutingLogic?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchCharacters()
    }
}

extension HomeSceneViewController: HomeSceneDisplayView {
    func didFetchCharacters(viewModel: [HomeScene.Search.ViewModel]) {
        // TODO: Implement
      
    }
    
    func failedToFetchCharacters(error: Error) {
        // TODO: Implement
      let alert = UIAlertController(title: "Character Fetch", message: "Sorry we are unable to load data", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
          switch action.style{
              case .default:
              print("default")
              
              case .cancel:
              print("cancel")
              
              case .destructive:
              print("destructive")
              
              @unknown default:
              print("Will b use in future IA")
          }
      }))
      self.present(alert, animated: true, completion: nil)
    }
}
