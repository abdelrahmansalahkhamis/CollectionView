//
//  FlowLayout.swift
//  CollectionView
//
//  Created by abdulrahman on 4/29/20.
//  Copyright © 2020 abdulrahmanAbdou. All rights reserved.
//

import Foundation
import UIKit

class FlowLayout: UICollectionViewFlowLayout{
    
    var addedItem: IndexPath?
    var deletedItems: [IndexPath]?
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath), let deleted = deletedItems, deleted.contains(itemIndexPath) else{
            return nil
        }
        attributes.alpha = 1.0
        attributes.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        attributes.zIndex = -1
        return attributes
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath), let added = addedItem, added == itemIndexPath else{
            return nil
        }
        attributes.center = CGPoint(x: collectionView!.frame.width - 23.5, y: -24.5)
        attributes.alpha = 1.0
        attributes.transform = CGAffineTransform(scaleX: 0.15, y: 0.15)
        attributes.zIndex = 5
        
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var result = [UICollectionViewLayoutAttributes]()
        if let attributes = super.layoutAttributesForElements(in: rect){
            for item in attributes{
                let cellAttribution = item.copy() as! UICollectionViewLayoutAttributes
                if item.representedElementKind == nil{
                    let frame = cellAttribution.frame
                    cellAttribution.frame = frame.insetBy(dx: 2.0, dy: 2.0)
                }
                result.append(cellAttribution)
            }
        }
        return result
    }
    
    
}
