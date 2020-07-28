//
//  CollectionTableViewCell.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 23/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell{
    
    
    static let identifier = "CollectionTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "CollectionTableViewCell", bundle: nil)
    }
    var models: [DataGettable]?
    var delegate : ReusableCellDelegate?
    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(ReusableCollectionViewCell.nib(), forCellWithReuseIdentifier: ReusableCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        setupFlowLayout()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupFlowLayout(){
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: collectionView.frame.size.height)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 0.8
        flowLayout.sideItemAlpha = 1.0
        flowLayout.spacingMode = .fixed(spacing: 30.0)
        collectionView.collectionViewLayout = flowLayout
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func configure(for models: [DataGettable]){
        self.models = models
        collectionView.reloadData()
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) else {return}
        cell.alpha = 0.8
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            cell.alpha = 1
        }
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.cellClicked(indexPath)
    }
}

extension CollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReusableCollectionViewCell.identifier, for: indexPath) as! ReusableCollectionViewCell
        if let safeModel = models?[indexPath.row] {
            cell.configure(for: safeModel)
        }else{
            delegate?.raiseAlert()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = self.frame.size.height
        let width = self.frame.size.width
        return CGSize(width: width * 0.7, height: height * 0.7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 35, bottom: 0, right: 35)
    }
}
