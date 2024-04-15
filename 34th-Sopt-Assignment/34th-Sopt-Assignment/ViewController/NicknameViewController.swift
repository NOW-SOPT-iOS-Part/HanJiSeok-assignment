//
//  NicknameViewController.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/15/24.
//

import UIKit

import SnapKit

class NicknameViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TVING ID 로그인"
        label.font = UIFont(name: "Pretendard-Medium", size: 23)
        label.textColor = .tvingGray1
        label.textAlignment = .center
        return label
    }()

    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .tvingGray2
        let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: .tvingGray2 ]
        textField.attributedPlaceholder = NSAttributedString(string: "아이디",
                                                             attributes: attributes)
        textField.leftPadding()
        textField.idRightView()
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        textField.backgroundColor = .tvingGray4
        textField.layer.cornerRadius = 3
//        textField.addTarget(self,
//                            action: #selector(textFieldDidChange),
//                            for: .editingChanged)
        return textField
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .tvingRed
        button.setTitle("저장하기", for: .normal)
        button.setTitleColor(.tvingWhite, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .tvingWhite
        setLayout()
        setAutoLayout()
    }

    private func setLayout() {
        [titleLabel, nicknameTextField, saveButton].forEach { [weak self] item in
            guard let self = self else { return }
            self.view.addSubview(item)
        }
    }

    private func setAutoLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(14)
            $0.leading.equalTo(view.snp.leading).offset(20)
            $0.height.equalTo(27)
        }

        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(view.snp.leading).offset(20)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
            $0.height.equalTo(52)
        }

        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-12)
            $0.leading.equalTo(view.snp.leading).offset(20)
            $0.trailing.equalTo(view.snp.trailing).offset(-20)
            $0.height.equalTo(52)
        }
    }

}
