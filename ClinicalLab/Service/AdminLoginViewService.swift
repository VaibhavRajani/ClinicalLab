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
        dateFormatter.dateFormat = "MM/DD/YYYY hh:mm:ss a" 
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: date)
        } else {
            return self
        }
    }
}

extension Color {
    static let customPink = Color(red: 140 / 255, green: 36 / 255, blue: 68 / 255)
}
