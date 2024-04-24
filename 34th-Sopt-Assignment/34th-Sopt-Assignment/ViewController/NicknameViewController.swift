//
//  NicknameViewController.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/15/24.
//

import UIKit

import SnapKit

protocol NicknameDelegate {
    func dataSend(data: String)
}

class NicknameViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임을 입력해주세요!"
        label.font = UIFont(name: "Pretendard-Medium", size: 23)
        label.textColor = .tvingBlack
        label.textAlignment = .center
        return label
    }()

    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .tvingGray4
        let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: .tvingGray4 ]
        textField.attributedPlaceholder = NSAttributedString(string: "아이디",
                                                             attributes: attributes)
        textField.leftPadding()
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        textField.backgroundColor = .tvingGray2
        textField.layer.cornerRadius = 3
        textField.addTarget(self,
                            action: #selector(textFieldDidChange),
                            for: .editingChanged)
        return textField
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .tvingGray2
        button.setTitle("저장하기", for: .normal)
        button.setTitleColor(.tvingBlack, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        button.layer.cornerRadius = 3
        button.addTarget(self,
                         action: #selector(saveButtonTapped),
                         for: .touchUpInside)
        return button
    }()

    var delegate: NicknameDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .tvingWhite
        setLayout()
        setAutoLayout()
    }

    private func setLayout() {
        [
            titleLabel,
            nicknameTextField,
            saveButton
        ].forEach { self.view.addSubview($0) }
    }

    private func setAutoLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
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

extension NicknameViewController {

    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let nickname = nicknameTextField.text else { return }
        let value = !nickname.isEmpty
        saveButton.isEnabled = value
        saveButton.backgroundColor = value ? .tvingRed : .tvingGray2
        saveButton.setTitleColor(value ? .tvingWhite : .tvingBlack,
                                  for: .normal)
    }

    @objc func saveButtonTapped(_ sender: UIButton) {
        if let nickname = nicknameTextField.text {
            delegate?.dataSend(data: nickname)
        }
        self.dismiss(animated: true)
    }
}
