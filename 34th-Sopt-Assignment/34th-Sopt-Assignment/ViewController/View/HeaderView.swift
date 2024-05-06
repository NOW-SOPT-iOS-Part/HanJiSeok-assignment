//
//  HeaderView.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/29/24.
//

import UIKit

import SnapKit

class HeaderView: UICollectionReusableView {
    
    static let identifier = "HeaderView"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Pretendard-Bold", size: 15)
        return label
    }()

    private let nextButton: UILabel = {
        let label = UILabel()
        label.text = "전체보기 >"
        label.textColor = .tvingGray2
        label.font = UIFont(name: "Pretendard-SemiBold", size: 11)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }

    func setUI() {
        self.addSubview(titleLabel)
        self.addSubview(nextButton)
    }

    func setAutoLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading)
            $0.centerY.equalTo(self.snp.centerY)
        }
        nextButton.snp.makeConstraints {
            $0.trailing.equalTo(self.snp.trailing).inset(8)
            $0.centerY.equalTo(self.snp.centerY)
        }
    }

    func bindData(title: String) {
        self.titleLabel.text = title
    }
}
