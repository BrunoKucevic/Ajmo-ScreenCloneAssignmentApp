//
//  ReusableCollectionViewCell.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 22/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import UIKit

class ReusableCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var linkType: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    
    @IBOutlet weak var viewImgView: UIImageView!
    @IBOutlet weak var dontMissThisView: UIView!
    
    
    static let identifier = "ReusableCollectionViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "ReusableCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setup(){
        imgView.layer.cornerRadius = imgView.frame.height / 10
        imgView.clipsToBounds = true
        mainview.layer.cornerRadius = mainview.frame.height / 10
        mainview.layer.shadowColor = UIColor.black.cgColor
        mainview.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        mainview.layer.shadowRadius = 2.0
        mainview.layer.shadowOpacity = 0.5
        imgView.layer.masksToBounds = true
        dontMissThisView.layer.cornerRadius = dontMissThisView.frame.height / 2
        viewImgView.clipsToBounds = true
    }
    
    public func configure(for model: DataGettable){
        dontMissThisView.isHidden = true
        self.title.text = model.title
        self.caption.text! = model.caption
        
        if model.isHighlighted{
            self.dontMissThisView.isHidden = false
        }
        
        self.linkType.text = model.linkType
        self.createdAt.text = "Published: " + model.createdAt.toDay
        if let image = model.imageURL{
            self.imgView.downloaded(from: image)
        }
        else {
            self.imgView.image = UIImage(named: "default")
        }
    }
}
