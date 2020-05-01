//
//  SectionView.swift
//  CollectionView
//
//  Created by abdulrahman on 4/29/20.
//  Copyright © 2020 abdulrahmanAbdou. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var flagImg: UIImageView!
    @IBOutlet weak var countLbl: UILabel!
    
    var section: Section!{
        didSet{
            titleLabel.text = section.title
            flagImg.image = UIImage(named: section.title ?? "")
            countLbl.text = "\(section.count)"
        }
    }
    
    var title: String?{
        didSet{
            titleLabel.text = title
        }
    }
}
