//
//  VisibleButton.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/15/24.
//

import UIKit

class VisibleButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }

    func setUI() {
        let visibleImage = UIImage(systemName: "eye.circle")
        self.setImage(visibleImage, for: .normal)
        self.tintColor = .tvingGray1
        self.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.contentMode = .scaleAspectFit
    }
}
