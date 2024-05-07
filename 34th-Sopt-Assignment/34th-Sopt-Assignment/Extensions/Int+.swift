//
//  Int+.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 5/7/24.
//

import Foundation

extension Int {
    func toKoreanNumber() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let units = ["", "만", "억", "조", "경"]
        var number = self
        var unitIndex = 0
        var result = ""

        while number > 0 {
            let part = number % 10000
            if part > 0 {
                if let partFormatted = numberFormatter.string(from: NSNumber(value: part)) {
                    result = partFormatted + units[unitIndex] + " " + result
                }
            }
            number /= 10000
            unitIndex += 1
        }

        return result.isEmpty ? "0" : result
    }
}
