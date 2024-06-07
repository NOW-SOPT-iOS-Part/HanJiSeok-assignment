//
//  ViewController.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/10/24.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

class LoginViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TVING ID 로그인"
        label.font = UIFont(name: "Pretendard-Medium", size: 23)
        label.textColor = .tvingGray1
        label.textAlignment = .center
        return label
    }()

    private let idTextField: UITextField = {
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
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .tvingGray2
        let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: .tvingGray2 ]
        textField.attributedPlaceholder = NSAttributedString(string: "비밀번호",
                                                             attributes: attributes)
        textField.leftPadding()
        textField.passwordRightView()
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        textField.backgroundColor = .tvingGray4
        textField.layer.cornerRadius = 3
        textField.isSecureTextEntry = true
        return textField
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인하기", for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        button.backgroundColor = .tvingBlack
        button.setTitleColor(.tvingGray2, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tvingGray2.cgColor
        button.layer.cornerRadius = 6
        button.isEnabled = false
        return button
    }()

    private lazy var findIdButton: UIButton = {
        let button = UIButton()
        button.setTitle("아이디 찾기", for: .normal)
        button.setTitleColor(.tvingGray2, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        return button
    }()

    private lazy var findPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(.tvingGray2, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        return button
    }()

    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .tvingGray4
        return view
    }()

    private let helpLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 계정이 없으신가요?"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        label.textColor = .tvingGray3
        return label
    }()

    private lazy var nicknameButton: UIButton = {
        let button = UIButton()
        button.setTitle("닉네임 만들러 가기", for: .normal)
        button.setTitleColor(.tvingGray2, for: .normal)
        button.addUnderline()
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        button.addTarget(self,
                         action: #selector(nicknameButtonTapped),
                         for: .touchUpInside)
        return button
    }()

    private var nickname: String? = nil
    private let viewModel: LoginViewModel
    private let disposeBag = DisposeBag()

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setAutoLayout()
        setDelegate()
        bind()
    }

    private func setStyle() {
        self.view.backgroundColor = .tvingBlack
    }

    private func setLayout() {
        [
            titleLabel,
            idTextField,
            passwordTextField,
            loginButton,
            findIdButton,
            findPasswordButton,
            divider,
            helpLabel,
            nicknameButton
        ].forEach { self.view.addSubview($0) }
    }

    private func setAutoLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(90)
        }

        idTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(21)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(58)
        }

        divider.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(36)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(12)
        }

        findIdButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(31)
            $0.trailing.equalTo(divider.snp.leading).offset(-33)
            $0.height.equalTo(22)
        }

        findPasswordButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(31)
            $0.leading.equalTo(divider.snp.trailing).offset(36)
            $0.height.equalTo(22)
        }

        helpLabel.snp.makeConstraints {
            $0.top.equalTo(findIdButton.snp.bottom).offset(28)
            $0.trailing.equalTo(self.view.snp.centerX)
            $0.height.equalTo(22)
        }

        nicknameButton.snp.makeConstraints {
            $0.top.equalTo(findPasswordButton.snp.bottom).offset(28)
            $0.leading.equalTo(helpLabel.snp.trailing).offset(34)
            $0.height.equalTo(22)
        }
    }

    private func setDelegate() {
        idTextField.delegate = self
        passwordTextField.delegate = self
    }

    private func bind() {
        let input = LoginViewModel.Input(
            idTextFieldChangeEvent: idTextField.rx.text.asObservable(),
            passwordTextFieldChangeEvent: passwordTextField.rx.text.asObservable(),
            loginButtonDidTapEvent: loginButton.rx.tap.asObservable()
        )
        let output = viewModel.transform(input)

        output.isLoginSucceeded
            .subscribe { [weak self] id in
                guard let self = self else { return }
                let welcomeViewController = WelcomeViewController()
                welcomeViewController.setLabelText(id: id)
                self.navigationController?.pushViewController(welcomeViewController, animated: true)
            }
            .disposed(by: disposeBag)

        output
            .isValid
            .bind(to: self.rx.loginButtonEnabled)
            .disposed(by: disposeBag)
    }
}

extension LoginViewController {
    @objc func nicknameButtonTapped(_ sender: UIButton) {
        let nicenameViewController = NicknameViewController()
        if let sheet = nicenameViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        nicenameViewController.delegate = self
        self.present(nicenameViewController, animated: true)
    }
}

extension LoginViewController: NicknameDelegate {
    func dataSend(data: String) {
        self.nickname = data
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.tvingGray1.cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = nil
    }
}

extension Reactive where Base: LoginViewController {
    var loginButtonEnabled: Binder<Bool> {
        return Binder(self.base) { viewController, value in
            viewController.loginButton.isEnabled = value
            viewController.loginButton.backgroundColor = value ? .tvingRed : .tvingBlack
            viewController.loginButton.setTitleColor(value ? .tvingWhite : .tvingGray2,
                                                     for: .normal)
            viewController.loginButton.layer.borderWidth = value ? 0 : 1
            viewController.loginButton.layer.borderColor = value ? nil : UIColor.tvingGray2.cgColor
        }
    }
}
