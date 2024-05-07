//
//  String+.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/15/24.
//

import Foundation

extension String {
    func isIdVaild() -> Bool {
        let idregex = "^[a-zA-Z0-9]{6,20}$"
        let idTest = NSPredicate(format: "SELF MATCHES %@", idregex)
        return idTest.evaluate(with: self)
    }

    func isPasswordVaild() -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: self)
    }

    func formattedWithSeparator() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale.current

        guard let number = numberFormatter.number(from: self) else { return self }

        return numberFormatter.string(from: number) ?? self
    }
}
