//
//  SavedItemsCoordinator.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 25/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import Foundation
import UIKit

class ItemsListCoordinator : NSObject, Coordinator, UINavigationControllerDelegate{


    weak var parentCoordinator : MainScreenCoordinator?
    var childCoordinators = [Coordinator]()
    var modelArray : [DataGettable]
    var navigationController: UINavigationController

    init(navigationController: UINavigationController, modelArray: [DataGettable]) {
        self.navigationController = navigationController
        self.modelArray = modelArray
    }
    
    func start() {
        let vc = ItemsListViewController.instantiate()
        navigationController.delegate = self
        vc.coordinator = self
        vc.modelArray = modelArray
        navigationController.pushViewController(vc, animated: false)
    }

}
