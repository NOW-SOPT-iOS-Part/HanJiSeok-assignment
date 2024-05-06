//
//  UILabel+.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/29/24.
//

import Foundation
import UIKit

extension String {
    func size(_ font: UIFont) -> CGSize {
        let size = (self as NSString).size(withAttributes: [.font: font])
        let buffer = 0.2
        return CGSize(width: size.width + buffer + 5, height: size.height)
    }
}
