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
    
    // MARK: - Instance variables
    var interactor: HomeSceneBusinessLogic?
    var router: HomeSceneRoutingLogic?
    var homeCustomCollectionManager: HomeCustomCollection?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchCharacters()
        self.setupInitalView()
    }
}

extension HomeSceneViewController: HomeSceneDisplayView {
    func didFetchCharacters(viewModel: [HomeScene.Search.ViewModel]) {
        // TODO: Implement
        // here we assigned received viewmodels to out data source and delegate object and reload collection
        self.homeCustomCollectionManager?.viewModels = viewModel
      
        // to reload the collection view after the data source is ready
        self.homeCustomCollectionManager?.reloadCollection()
      
    }
    
    func failedToFetchCharacters(error: Error) {
        // TODO: Implement
      
        print(error.localizedDescription)
        // just incae we recieve error from server a ui alertview will be presented for user info
        let alert = UIAlertController(title: "The Hitchhiker Prophecy", message: "Sorry we are unable to load data", preferredStyle: .alert)
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

// MARK: - Helper MEthods extension
extension HomeSceneViewController {
  
  // To setup the inital settting of view controller
    func setupInitalView() {
        
        homeCustomCollectionManager = HomeCustomCollection(with: self.charactersList, router: self.router)
        
        let button = UIBarButtonItem(image: nil, style: .plain, target: homeCustomCollectionManager, action: #selector(homeCustomCollectionManager?.changeLayoutButtonPressed(_:)))
        button.title = "Change Layout"
        button.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = button
        
        charactersList.delegate = homeCustomCollectionManager
        charactersList.dataSource = homeCustomCollectionManager
    }
}
