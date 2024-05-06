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

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI() {

    }

    func setAutoLayout() {

    }

    func bindData(_ movie: MovieModel) {

    }
}
