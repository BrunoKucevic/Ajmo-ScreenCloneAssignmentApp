//
//  DetailsViewController.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 27/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, StoryBoarded {


    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var event: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    weak var coordinator : DetailsViewCoordinator?
    var model : DataGettable?
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(){
        guard let model = model else {return}
        titleLabel.text = model.title
        descrLabel.text = model.datumDescription
        event.text = model.linkType
        createdAt.text = "Published: " + model.createdAt.toDay
        if model.picture.isStringNilOrEmpty(){
            guard let img = model.imageURL else {return}
            image.downloaded(from: img)
        }else{
            image.downloaded(from: model.picture)
        }
        
    }
}
