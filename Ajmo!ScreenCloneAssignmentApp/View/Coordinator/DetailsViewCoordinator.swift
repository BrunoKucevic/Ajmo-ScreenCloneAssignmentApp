//
//  DetailsViewCoordinator.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 27/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewCoordinator : NSObject, Coordinator, UINavigationControllerDelegate{


    weak var parentCoordinator : MainScreenCoordinator?
    var childCoordinators = [Coordinator]()
    var model : DataGettable
    var navigationController: UINavigationController

    init(navigationController: UINavigationController, model: DataGettable) {
        self.navigationController = navigationController
        self.model = model
    }
    
    func start() {
        let vc = DetailsViewController.instantiate()
        navigationController.delegate = self
        vc.coordinator = self
        vc.model = model
        navigationController.pushViewController(vc, animated: false)
    }

}
