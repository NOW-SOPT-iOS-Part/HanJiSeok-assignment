//
//  ViewModelType.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 6/4/24.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(_ input: Input) -> Output
}
