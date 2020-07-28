//
//  Int.swift
//  Ajmo!ScreenCloneAssignmentApp
//
//  Created by Bruno Kucevic on 24/07/2020.
//  Copyright © 2020 Bruno Kucevic. All rights reserved.
//

import Foundation


extension Int {
    private func formatType(form: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = form
        return dateFormatter
    }
    var dateFull: Date {
        return Date(timeIntervalSince1970: Double(self))
    }
    var toDay: String {
        return formatType(form: "dd.MM.yyyy").string(from: dateFull)
    }
}
