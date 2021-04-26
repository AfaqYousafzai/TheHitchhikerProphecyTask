//
//  CollectionHorizontolDirection.swift
//  The Hitchhiker Prophecy
//
//  Created by Afaq Ahmad on 26/04/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import UIKit

// The horizontal direction of collection view along with its offset managment will be handled here.
class CollectionHorizontolDirection: UICollectionViewFlowLayout {
    
    var width: CGFloat = 0
    var height: CGFloat = 0
    let scaleFactor: CGFloat = 0.8
        
    override init() {
        super.init()

        scrollDirection = .horizontal
        minimumLineSpacing = 20
        width = UIScreen.main.bounds.width * scaleFactor
        height = UIScreen.main.bounds.height * scaleFactor
        
        itemSize = CGSize(width: width, height: height)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalOffset = proposedContentOffset.x
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: self.collectionView!.bounds.width * scaleFactor, height: self.collectionView!.bounds.height * scaleFactor)

        for layoutAttributes in super.layoutAttributesForElements(in: targetRect)! {
            let itemOffset = layoutAttributes.frame.origin.x
            if (abs(itemOffset - horizontalOffset) < abs(offsetAdjustment)) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        }

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment - (UIScreen.main.bounds.width - width)/2, y: proposedContentOffset.y)
    }
}
