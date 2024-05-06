//
//  PosterCell.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/26/24.
//

import UIKit

import SnapKit

final class PosterCell: UICollectionViewCell {
    
    static let identifier = "PosterCell"

    private let posterImageView = UIImageView()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Bold", size: 24)
        label.textColor = .white
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Medium", size: 17)
        label.textColor = .white
        label.numberOfLines = 2
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
        self.addSubview(posterImageView)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)

    }

    private func setAutoLayout() {
        posterImageView.snp.makeConstraints {
            $0.verticalEdges.horizontalEdges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.size.width)
            $0.height.equalTo(UIScreen.main.bounds.size.width * 1.328)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(130)
        }

        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(70)
        }
    }

    func bindData(_ poster: Poster) {
        self.posterImageView.image = poster.image
        self.titleLabel.text = poster.title
        self.descriptionLabel.text = poster.description
    }
}
