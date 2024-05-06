//
//  PosterPageControl.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/29/24.
//

import UIKit
import Combine

import SnapKit

final class PosterPageControl: UICollectionReusableView {

    static let identifier = "PosterPageControl"
    let pageControl = UIPageControl()

    var cancellable = Set<AnyCancellable>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        addSubview(pageControl)
        pageControl.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(-40)
        }
        pageControl.numberOfPages = 5
        pageControl.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }

    func bind(pagingInfoSubject: PassthroughSubject<Int, Never>, section: Int) {
        cancellable = []
        let _ = pagingInfoSubject
            .receive(on: RunLoop.main)
            .sink { [weak self] page in
                guard let self = self else { return }
                self.pageControl.currentPage = page
            }
            .store(in: &cancellable)
    }
}
