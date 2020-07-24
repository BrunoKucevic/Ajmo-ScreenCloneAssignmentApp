//
//  Storyboarded.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 22/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import Foundation
import UIKit

protocol StoryBoarded{
    static func instantiate() -> Self
}

extension StoryBoarded where Self: UIViewController{
    static func instantiate() -> Self{
        let id = String(describing: self)
        let storyBoard = UIStoryboard(name: id, bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: id) as! Self
    }
}
