//
//  Coordinator.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 22/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject{
    var childCoordinators : [Coordinator] {get set}
    var navigationController : UINavigationController {get set}
    
    func start()
}
