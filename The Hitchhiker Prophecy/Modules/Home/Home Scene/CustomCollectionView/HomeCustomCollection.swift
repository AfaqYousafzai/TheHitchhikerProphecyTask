//
//  HomeCustomCollection.swift
//  The Hitchhiker Prophecy
//
//  Created by Afaq Ahmad on 25/04/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import UIKit

class HomeCustomCollection: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    weak var collectionView: UICollectionView?
    var router: HomeSceneRoutingLogic?
    var viewModels: [HomeScene.Search.ViewModel]?
    
    private var indexOfCellBeforeDragging = 0
    private var collectionViewFlowLayout: UICollectionViewFlowLayout {
        return self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
    }

    // We will need router here for selection of characters also the collection view registering as it is designed using xib file and not the storyboard.
    init(with collectionView: UICollectionView, router: HomeSceneRoutingLogic?) {
        super.init()
        self.collectionView = collectionView
        self.collectionView?.register(UINib(nibName: "HomeCharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCharacterCollectionViewCell")
       
        self.collectionView?.collectionViewLayout = ListCollectionFlowVerticlDirection()
        self.router = router
    }
    
  // To change the layout after press the button
    @objc func changeLayoutButtonPressed(_ sender: UIBarButtonItem) {
        let isListView = self.collectionView?.collectionViewLayout is ListCollectionFlowVerticlDirection
        if isListView {
            self.collectionView?.setCollectionViewLayout(CollectionHorizontolDirection(), animated: true)
            reloadCollection()
        }
        else {
            self.collectionView?.setCollectionViewLayout(ListCollectionFlowVerticlDirection(), animated: true)
            reloadCollection()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCharacterCollectionViewCell", for: indexPath) as? HomeCharacterCollectionViewCell {
          if let validViewModel = self.viewModels?[indexPath.row] {
                cell.configure(with: validViewModel)
            }
            return cell
        }
        
        return HomeCharacterCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.router?.routeToCharacterDetailsWithCharacter(at: indexPath.row)
    }
    
    public func reloadCollection() {
        self.collectionView?.reloadData()
    }
}
