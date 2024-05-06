//
//  TabHeaderView.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/29/24.
//

import UIKit

import SnapKit

final class TabHeaderView: UIView {

    enum Metric {
        static let interItemSpacing = 28.0
        static let underlineViewHeight = 4.0
        static let underlineViewTopSpacing = 6.0
        static let collectionViewBottomSpacing = underlineViewHeight + underlineViewTopSpacing
        static let duration = 0.2
    }

    let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumInteritemSpacing = Metric.interItemSpacing

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = .zero
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.register(TabHeaderCell.self,
                                forCellWithReuseIdentifier: TabHeaderCell.identifier)
        return collectionView
    }()

    let items: [String] = ["홈", "실시간", "TV 프로그램", "영화", "파라마운드+"]
    var selectedIndex = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setAutoLayout()
        setDelegate()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI() {
        addSubview(collectionView)
    }

    func setAutoLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(4)
            $0.bottom.equalToSuperview().inset(Metric.collectionViewBottomSpacing)
        }
    }


    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func itemSize(index: Int) -> CGSize {
        items[index].size(.systemFont(ofSize: 17))
    }
}

extension TabHeaderView: TabCollectionViewCellDelegate {
    func titleButtonTapped(_ cell: TabHeaderCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        selectedIndex = indexPath.row
        collectionView.reloadData()
    }
}

extension TabHeaderView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TabHeaderCell.identifier,
            for: indexPath
        ) as? TabHeaderCell
        else { return UICollectionViewCell() }
        cell.bindData(
            title: items[indexPath.row],
            color: indexPath.row == selectedIndex ? .white : .gray,
            underlineColor: indexPath.row == selectedIndex ? .white : .clear
        )
        cell.underlineConstraints(cgSize: self.itemSize(index: indexPath.row))
        cell.delegate = self
        return cell
    }
}

extension TabHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return self.itemSize(index: indexPath.row)
    }
}
