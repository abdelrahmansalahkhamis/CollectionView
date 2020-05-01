//
//  ViewController.swift
//  CollectionView
//
//  Created by abdulrahman on 4/22/20.
//  Copyright © 2020 abdulrahmanAbdou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var collectionData = ["1 😃", "2 🐸", "3 🤪", "4 🥰", "5 😜", "6 🤓", "7 😼", "8 😲", "9 🤩", "10 👶🏻", "11 🐱", "12 🐠"]
    
    @IBOutlet weak var addBtn: UIBarButtonItem!
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private let dataSource = DataSource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (view.frame.size.width - 20) / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionHeadersPinToVisibleBounds = true
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        collectionView.refreshControl = refresh
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        navigationController?.isToolbarHidden = true
        
        //installsStandardGestureForInteractiveMovement = true
    }
    
    @objc func refresh(){
        addItem()
        collectionView.refreshControl?.endRefreshing()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addBtn.isEnabled = !editing
        collectionView.allowsMultipleSelection = editing
        
        // this gets a list of all selected paths for all the selected paths and deselect them
        collectionView.indexPathsForSelectedItems?.forEach{
            collectionView.deselectItem(at: $0, animated: false)
        }
        
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths{
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            cell.isEditing = editing
        }
        deleteBtn.isEnabled = isEditing
        if !editing{
            navigationController?.isToolbarHidden = true
        }
    }
    
    @IBAction func addItem(){
        
//        collectionView.performBatchUpdates({
//            for _ in 0..<2{
//                let text = "\(collectionData.count + 1) 🐠"
//                collectionData.append(text)
//                let indexPath = IndexPath(row: collectionData.count - 1, section: 0)
//                collectionView.insertItems(at: [indexPath])
//            }
//        }, completion: nil)
        
        let index = dataSource.indexPathForNewRandomPark()
        let layout = collectionView.collectionViewLayout as! FlowLayout
        layout.addedItem = index
        
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.0, options: [], animations: {
            self.collectionView.insertItems(at: [index])
        }){ finished in
            layout.addedItem = nil
        }
        
    }
    
    @IBAction func deletePressed(){
        if let selected = collectionView.indexPathsForSelectedItems{
            
            let layout = collectionView.collectionViewLayout as! FlowLayout
            layout.deletedItems = selected
            
            dataSource.deleteItemsAtIndexPaths(selected)
            collectionView.deleteItems(at: selected)
            navigationController?.isToolbarHidden = true
            
            // safely remove indeces
//            let items = selected.map{ $0.item }.sorted().reversed()
//            for item in items{
//                collectionData.remove(at: item)
//            }
//            collectionView.deleteItems(at: selected)
        }
//        navigationController?.isToolbarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue"{
            if let detailVC = segue.destination as? DetailVC, let index = sender as? IndexPath {
                detailVC.selected = collectionData[index.row]
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfParksInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) as! CollectionViewCell
        
//        cell.titleLbl.text = collectionData[indexPath.row]
//        cell.isEditing = isEditing
        
        cell.park = dataSource.parkForItemAtIndexPath(indexPath)
        cell.isEditing = isEditing 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing{
            performSegue(withIdentifier: "DetailSegue", sender: indexPath)
        }else{
            navigationController?.isToolbarHidden = false
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isEditing{
            if let selected = collectionView.indexPathsForSelectedItems, selected.count == 0{
                navigationController?.isToolbarHidden = true
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
        
        let section = Section()
        section.title = dataSource.titleForSectionAtIndexPath(indexPath)
        section.count = dataSource.numberOfParksInSection(indexPath.section)
        view.section = section
        //view.title = dataSource.titleForSectionAtIndexPath(indexPath)
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        dataSource.moveParkAtIndexPath(sourceIndexPath, toIndexPath: destinationIndexPath)
    }
    
}

