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

    func goToDetails(_ item: DataGettable){
        let child = DetailsViewCoordinator(navigationController: navigationController, model: item)
        child.parentCoordinator2 = self
        childCoordinators.append(child)
        child.start()
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {return}
        
        if navigationController.viewControllers.contains(fromViewController){
            return
        }
        
        if let savedItemsCoordinator = fromViewController as? ItemsListViewController{
            childDidFinish(savedItemsCoordinator.coordinator!)
        }
    }
    
    func childDidFinish(_ child: Coordinator){
        for (index, coordinator) in childCoordinators.enumerated(){
            if coordinator === child{
                childCoordinators.remove(at: index)
            }
        }
    }
}
