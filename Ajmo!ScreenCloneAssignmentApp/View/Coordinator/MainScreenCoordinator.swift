//
//  MainScreenCoordinator.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 22/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import Foundation
import UIKit

class MainScreenCoordinator : NSObject, Coordinator, UINavigationControllerDelegate{

    
    var childCoordinators = [Coordinator]()

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainScreenViewController.instantiate()
        navigationController.delegate = self
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

}
