//
//  MainTabBarController.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 22/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    let mainCoord = MainScreenCoordinator(navigationController: UINavigationController())
//    let historyCoordinator = HistoryCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCoord.start()
        //tvShowsCoordinator.start()
        viewControllers = [mainCoord.navigationController]
    }

}
