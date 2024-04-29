//
//  PosterCell.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/26/24.
//

import UIKit

import SnapKit

class PosterCell: UICollectionViewCell {

    static let identifier = "PosterCell"

    let posterImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setLayout()
        setAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLayout() {
        self.addSubview(posterImageView)
    }

    private func setAutoLayout() {
        posterImageView.snp.makeConstraints {
            $0.verticalEdges.horizontalEdges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.size.width)
            $0.height.equalTo(UIScreen.main.bounds.size.width * 1.328)
        }
    }

}
