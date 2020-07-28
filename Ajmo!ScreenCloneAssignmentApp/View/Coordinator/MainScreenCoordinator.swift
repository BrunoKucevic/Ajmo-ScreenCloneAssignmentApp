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
        navigationController.navigationBar.backgroundColor = UIColor.colorSecond()
        navigationController.title = "Discover"
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToList(_ items: [DataGettable]){
        let child = ItemsListCoordinator(navigationController: navigationController, modelArray: items)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func goToDetails(_ item: DataGettable){
        let child = DetailsViewCoordinator(navigationController: navigationController, model: item)
        child.parentCoordinator = self
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
