//
//  ListCollectionFlowVerticlDirection.swift
//  The Hitchhiker Prophecy
//
//  Created by Afaq Ahmad on 26/04/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import UIKit

// manage the cell with dynamic width and provided height.
class ListCollectionFlowVerticlDirection: UICollectionViewFlowLayout {
    
    let height: CGFloat = 170.0
    let width: CGFloat = UIScreen.main.bounds.width
    
    
    override init() {
        super.init()

        scrollDirection = .vertical
        minimumLineSpacing = 15
        itemSize = CGSize(width: width, height: height)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
