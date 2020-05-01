//
//  DetailVC.swift
//  CollectionView
//
//  Created by abdulrahman on 4/22/20.
//  Copyright © 2020 abdulrahmanAbdou. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var textLbl: UILabel!
    
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var stateLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    var park: Park?
    
    var selected: String!
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        if let park = park{
            navigationItem.title = park.name
            imageView.image = UIImage(named: park.photo)
            nameLabel.text = park.name
            stateLabel.text = park.state
            dateLabel.text = park.date
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textLbl.text = selected
    }
    

}
