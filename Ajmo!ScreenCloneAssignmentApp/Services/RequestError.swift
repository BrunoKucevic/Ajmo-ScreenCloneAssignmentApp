//
//  RequestError.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 23/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import Foundation

enum RequestError: Error{
    case clienError
    case serverError
    case noData
    case dataDecodingError
}
