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
        self.imgView.image = nil
        self.linkType.text = "event"
    }
    
    private func setup(){
        mainview.layer.cornerRadius = mainview.frame.height / 10
        mainview.layer.shadowColor = UIColor.black.cgColor
        mainview.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        mainview.layer.shadowRadius = 2.0
        mainview.layer.shadowOpacity = 0.5
        mainview.layer.masksToBounds = false
//        imgView.layer.cornerRadius = mainview.layer.cornerRadius / 10
//        imgView.clipsToBounds = true
    
        self.clipsToBounds = true
    }
    
    public func configure(for model: Data){
        self.title.text = model.title
        self.caption.text! = model.caption
        if model.links[0].linkType.rawValue.isStringNilOrEmpty(){
            self.linkType.text = "event"
        }else{
            self.linkType.text = model.links[0].linkType.rawValue
        }
        self.createdAt.text = "Published: " + model.createdAt.toDay
        guard let image = model.imageURL else {return}
        self.imgView.downloaded(from: image)
    }
}
