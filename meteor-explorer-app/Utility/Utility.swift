//
//  DateUtility.swift
//  meteor-explorer-app
//
//  Created by Feranmi on 17/09/2021.
//

import Foundation

func formatDate(dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = "MMM d, yyyy"

        return dateFormatter.string(from: date)
    }

    return ""
}

func convertMassToKg(mass: String) -> String {
    if var massValue = Double(mass) {
        if massValue == 0 {
            return "0"
        }
        massValue /= 1000
        return String(format: "%.2f", massValue)
    }

    return ""
}
