//
//  Date + ext.swift
//  MovieApp
//
//  Created by Илья Канторин on 29.03.2024.
//

import Foundation

extension Date {
    func monthName() -> String {
            let df = DateFormatter()
            df.setLocalizedDateFormatFromTemplate("MMM")
            return df.string(from: self)
    }
}
