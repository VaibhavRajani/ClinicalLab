//
//  AdminLoginViewService.swift
//  ClinicalLab
//
//  Created by Vaibhav Rajani on 2/12/24.
//

import Foundation
import SwiftUI

extension String {
    func formattedTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/DD/YYYY hh:mm:ss a" // Adjust to match the format of the input string
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Use POSIX locale to ensure consistency
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "h:mm a" // Format for the output string
            return dateFormatter.string(from: date)
        } else {
            return self // Return the original string if parsing fails
        }
    }
}

extension Color {
    static let customPink = Color(red: 140 / 255, green: 36 / 255, blue: 68 / 255)
}
