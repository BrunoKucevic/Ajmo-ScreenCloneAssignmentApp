//
//  Item.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 25/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object, DataGettable{
    @objc dynamic var linkType: String = ""
    
    @objc dynamic var imageURL: String?
    
    @objc dynamic var shareLink: String = ""
    
    @objc dynamic var picture: String = ""
    
    @objc dynamic var isHighlighted: Bool = false
    
    @objc dynamic var createdAt: Int = 0
    
    @objc dynamic var updatedAt: Int = 0
    
    @objc dynamic var caption: String = ""
    
    @objc dynamic var isPromoted: Int = 0
    
    @objc dynamic var highlightedIcon: String = ""
     
    @objc dynamic var title: String = ""
    
    @objc dynamic var datumDescription: String = ""
    
    @objc dynamic var id : Int = 0
    
    @objc dynamic var color : String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}



