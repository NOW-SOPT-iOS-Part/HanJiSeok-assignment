//
//  LoginViewModel.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 6/4/24.
//

import Foundation

import RxSwift
import RxRelay

final class LoginViewModel: ViewModelType {

    private var id: String = ""
    private var password: String = ""
    private let disposeBag = DisposeBag()

    struct Input {
        let idTextFieldChangeEvent: Observable<String?>
        let passwordTextFieldChangeEvent: Observable<String?>
        let loginButtonDidTapEvent: Observable<Void>
    }

    struct Output {
        let isValid = PublishRelay<Bool>()
        let isLoginSucceeded = PublishRelay<String>()
    }

    func transform(_ input: Input) -> Output {
        let output = Output()
        
        let accountValidation = Observable.combineLatest(
            input.idTextFieldChangeEvent.map { $0 ?? "" },
            input.passwordTextFieldChangeEvent.map { $0 ?? "" }
        )
        
        accountValidation
            .subscribe { [weak self] id, password in
                guard let self = self else { return }
                self.id = id
                self.password = password
                output.isValid.accept(self.isValid())
            }
            .disposed(by: disposeBag)

        input
            .loginButtonDidTapEvent
            .subscribe { [weak self] _ in
                guard let self = self, self.isValid() else { return }
                output.isLoginSucceeded.accept(self.id)
            }
            .disposed(by: disposeBag)

        return output
    }

    private func isValid() -> Bool {
        return self.id.isIdVaild() && self.password.isPasswordVaild()
    }
}
