//
//  SavedItemsCoordinator.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 25/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import Foundation
import UIKit

class SavedItemsCoordinator : NSObject, Coordinator, UINavigationControllerDelegate{

    
    var childCoordinators = [Coordinator]()

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SavedItemsViewController.instantiate()
        navigationController.delegate = self
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

}
