//
//  MockContents.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/28/24.
//

import UIKit

enum MockData {
    static let contents: [(UIImage, String)] = [
        (UIImage(resource: .contents1), "시그널"),
        (UIImage(resource: .contents2), "해리포터"),
        (UIImage(resource: .contents3), "맨시티"),
        (UIImage(resource: .contents4), "호날두"),
        (UIImage(resource: .contents5), "눈간지러")
    ]

    static let poster: [Poster] = [
        Poster(title: "너의 이름은", description: "키미토노 라부 수토리\n살려주세요", image: .contents5),
        Poster(title: "내 이름은 김삼순", description: "키미토노 라부 수토리\n살려주세요", image: .contents4),
        Poster(title: "누 구세요", description: "키미토노 라부 수토리\n살려주세요", image: .contents3),
        Poster(title: "누구 없소", description: "키미토노 라부 수토리\n살려주세요", image: .contents2),
        Poster(title: "안녕하시라", description: "키미토노 라부 수토리\n살려주세요", image: .contents1)
    ]

    static let title: [String] = [
        "티빙에서 꼭 봐야하는 컨텐츠",
        "한지석님이 시청하는 콘텐츠",
        "티빙 TOP 20 프로그램"
    ]
}
