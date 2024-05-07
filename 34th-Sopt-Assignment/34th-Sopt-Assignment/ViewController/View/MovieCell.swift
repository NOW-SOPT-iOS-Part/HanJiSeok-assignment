//
//  MovieCell.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 5/6/24.
//

import Foundation
import UIKit

final class MovieCell: UITableViewCell {

    static let identifier = "MovieCell"

    let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        label.textColor = .tvingGray5
        return label
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        return label
    }()

    let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        return label
    }()

    let audienceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        return label
    }()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        setUI()
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI() {
        [rankLabel, nameLabel, amountLabel, audienceLabel].forEach {
            addSubview($0)
        }
    }

    func setAutoLayout() {
        rankLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(12)
            $0.width.equalTo(33)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalTo(rankLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(12)
        }

        amountLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(36)
        }

        audienceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(8)
        }
    }

    func bindData(_ movie: MovieModel) {
        var amount = Int(movie.amount)!.toKoreanNumber().replacingOccurrences(of: ",", with: "")
        amount.removeLast()
        rankLabel.text = "\(movie.rank)등"
        nameLabel.text = movie.name
        amountLabel.text = "누적 매출액 - \(amount)원"
        audienceLabel.text = "누적 관객수 - \(movie.audience.formattedWithSeparator())명"
    }

}
