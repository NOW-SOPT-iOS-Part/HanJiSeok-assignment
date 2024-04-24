//
//  UIButton+.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/15/24.
//

import UIKit

extension UIButton {
    func addUnderline() {
        let attributedString = NSMutableAttributedString(string: self.titleLabel?.text ?? "")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
