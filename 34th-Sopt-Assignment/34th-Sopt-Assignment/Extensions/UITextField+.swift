//
//  UITextField+.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/15/24.
//

import Foundation
import UIKit

import SnapKit

extension UITextField {
    func leftPadding() {
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 23, height: self.frame.height))
        self.leftView = leftPaddingView
        self.leftViewMode = ViewMode.always
    }

    func idRightView() {
        let clearButton = ClearButton()
        clearButton.addTarget(self,
                              action: #selector(clearButtonTapped),
                              for: .touchUpInside)
        let padding = CustomPadding(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 16,
                                                  height: 0))
        padding.widthAnchor.constraint(equalToConstant: 16).isActive = true
        let buttonWithPadding = UIStackView()
        buttonWithPadding.axis = .horizontal
        buttonWithPadding.spacing = 0
        buttonWithPadding.addArrangedSubview(clearButton)
        buttonWithPadding.addArrangedSubview(padding)
        self.rightView = buttonWithPadding
        self.rightViewMode = .whileEditing
    }

    func passwordRightView() {
        let visibleButton = VisibleButton()
        visibleButton.addTarget(self,
                                action: #selector(visibleButtonTapped),
                                for: .touchUpInside)
        let clearButton = ClearButton()
        clearButton.addTarget(self,
                              action: #selector(clearButtonTapped),
                              for: .touchUpInside)
        let padding = CustomPadding(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 0,
                                                  height: 0))
        padding.widthAnchor.constraint(equalToConstant: 0).isActive = true
        let buttonsWithPadding = UIStackView()
        buttonsWithPadding.axis = .horizontal
        buttonsWithPadding.spacing = 16
        buttonsWithPadding.addArrangedSubview(clearButton)
        buttonsWithPadding.addArrangedSubview(visibleButton)
        buttonsWithPadding.addArrangedSubview(padding)
        self.rightView = buttonsWithPadding
        self.rightViewMode = .whileEditing
    }

    @objc func clearButtonTapped(_ sender: UIButton) {
        self.text = ""
    }

    @objc func visibleButtonTapped(_ sender: UIButton) {
        self.isSecureTextEntry.toggle()
        let image = UIImage(systemName: isSecureTextEntry ? "eye.circle" : "eye.slash.circle")
        sender.setImage(image, for: .normal)
    }
}
