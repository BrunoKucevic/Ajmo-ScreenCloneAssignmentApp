//
//  ItemListTableViewCell.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 26/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dontMissThis: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var linkType: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    static let identifier = "ItemListTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "ItemListTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.cornerRadius = cellView.frame.height / 20
        imgView.layer.cornerRadius = imgView.frame.height / 20
        imgView.clipsToBounds = true
        dontMissThis.layer.cornerRadius = dontMissThis.frame.height / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(model: DataGettable){
        dontMissThis.isHidden = true
        self.title.text = model.title
        
        
        
        if model.isHighlighted{
            self.dontMissThis.isHidden = false
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
