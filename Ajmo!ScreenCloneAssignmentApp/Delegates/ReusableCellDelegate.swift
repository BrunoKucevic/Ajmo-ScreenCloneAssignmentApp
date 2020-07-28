//
//  ReusableCellDelegate.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 28/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableCellDelegate {
    func cellClicked(_ indexPath: IndexPath)
    func raiseAlert()
}

