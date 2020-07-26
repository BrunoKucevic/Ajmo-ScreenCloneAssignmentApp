//
//  DataGettable.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 26/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import Foundation

protocol DataGettable {
    var id: Int { get }
    var linkType: String { get }
    var imageURL: String? { get }
    var shareLink: String { get }
    var isHighlighted: Bool { get }
    var createdAt: Int { get }
    var updatedAt: Int { get }
    var caption: String { get }
    var isPromoted: Int { get }
    var highlightedIcon: String { get }
    var title: String { get }
    var datumDescription: String { get }
    var picture: String { get }
}
