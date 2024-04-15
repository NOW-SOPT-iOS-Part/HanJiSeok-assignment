//
//  WelcomeViewController.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/15/24.
//

import UIKit

import SnapKit

class WelcomeViewController: UIViewController {

    private let welcomeImage: UIImageView = {
        let image = UIImage(resource: .login)
        let imageView = UIImageView()
        imageView.image = image
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Bold", size: 23)
        label.textColor = .tvingWhite
        return label
    }()

    private var id: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        bindId()
        setLayout()
        setAutoLayout()
    }

    func setLayout() {
        [welcomeImage, titleLabel].forEach { [weak self] item in
            guard let self = self else { return }
            self.view.addSubview(item)
        }
    }

    func setAutoLayout() {
        welcomeImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(14)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeImage.snp.bottom).offset(67)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(100)
        }
    }

    func bindId() {
        if let id = id {
            self.titleLabel.text = "\(id)님 반가워요!"
        } else {
            self.titleLabel.text = "Guest님 반가워요!"
        }
    }

    func setLabelText(id: String?) {
        self.id = id
    }
}
