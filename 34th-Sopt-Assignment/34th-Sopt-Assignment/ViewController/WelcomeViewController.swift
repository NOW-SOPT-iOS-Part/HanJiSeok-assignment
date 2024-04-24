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

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("메인으로", for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        button.backgroundColor = .tvingRed
        button.setTitleColor(.tvingWhite, for: .normal)
        button.layer.cornerRadius = 6
        button.addTarget(self,
                         action: #selector(backButtonTapped),
                         for: .touchUpInside)
        return button
    }()

    private var id: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        bindId()
        setLayout()
        setAutoLayout()
    }

    func setLayout() {
        [
            welcomeImage,
            titleLabel,
            backButton
        ].forEach { self.view.addSubview($0) }
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

        backButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-66)
            $0.leading.equalTo(view.snp.leading).offset(20)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
            $0.height.equalTo(52)
        }
    }

    @objc func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
