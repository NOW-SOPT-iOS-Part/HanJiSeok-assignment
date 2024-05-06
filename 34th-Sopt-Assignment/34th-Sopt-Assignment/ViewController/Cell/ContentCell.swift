//
//  ContentCell.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/26/24.
//

import UIKit

import SnapKit

final class ContentCell: UICollectionViewCell {
    
    static let identifier = "ContentCell"

    let contentImageView = UIImageView()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Medium", size: 10)
        label.textColor = .tvingGray2
        label.textAlignment = .left
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUI()
        setAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        self.addSubview(contentImageView)
        self.addSubview(titleLabel)
    }

    private func setAutoLayout() {
        contentImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(146)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentImageView.snp.bottom).offset(3)
            $0.leading.equalToSuperview()
        }
    }

    func bindData(
        image: UIImage,
        title: String
    ) {
        self.contentImageView.image = image
        self.titleLabel.text = title
    }
}
