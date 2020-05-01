//
//  CollectionViewCell.swift
//  CollectionView
//
//  Created by abdulrahman on 4/22/20.
//  Copyright © 2020 abdulrahmanAbdou. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var selectionImg: UIImageView!
    
    @IBOutlet private weak var mainImg: UIImageView!
    
    var park: Park?{
        didSet{
            if let park = park{
                mainImg.image = UIImage(named: park.photo)
                titleLbl.text = park.name
            }
        }
    }
    
    
    // to remove any image currently being displayed when the cell is recycled
    override func prepareForReuse() {
        mainImg.image = nil
    }
    
    var isEditing: Bool = false{
        didSet{
            selectionImg.isHidden = !isEditing
        }
        
    }
    
    override var isSelected: Bool{
        didSet{
            if isEditing{
                selectionImg.image = isSelected ? UIImage(named: "Checked") : UIImage(named: "Unchecked")
            }
        }
    }
    
}
