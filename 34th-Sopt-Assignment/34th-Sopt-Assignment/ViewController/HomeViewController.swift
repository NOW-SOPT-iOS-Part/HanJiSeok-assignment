//
//  HomeViewController.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/26/24.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    private enum Metric {
        static let headerHeight = 56.0
        static let headerViewHorizontalInset = 12.0
    }

    private var collectionView: UICollectionView? = nil
    private let tabHeaderView = TabHeaderView()
    private let navigationItemHiddenView: UIView = {
        let hiddenView = UIView()
        hiddenView.backgroundColor = .black
        hiddenView.isHidden = true
        return hiddenView
    }()

    let pagingInfoSubject = PassthroughSubject<Int, Never>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        makeCollectionView()
        setUI()
        setLayout()
    }

    private func setNavigationBar() {
        let titleImage = UIImage(resource: .tving)
        let titleImageView = UIImageView(image: titleImage)
        titleImageView.frame = CGRect(x: 0, y: 0, width: 99, height: 25)
        let titleView = UIView(frame: titleImageView.frame)
        titleView.addSubview(titleImageView)
        let leftItem = UIBarButtonItem(customView: titleView)

        let dusanImage = UIImage(resource: .dusan)
        let dusanImageView = UIImageView(image: dusanImage)
        let rightItem = UIBarButtonItem(customView: dusanImageView)

        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.rightBarButtonItem = rightItem
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }

    private func setUI() {
        self.view.backgroundColor = .black
        self.view.addSubview(tabHeaderView)
        self.view.addSubview(navigationItemHiddenView)
    }

    private func setLayout() {
        collectionView!.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-100)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
        navigationItemHiddenView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(60)
        }
        tabHeaderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Metric.headerHeight)
        }
    }

    private func makeCollectionView() {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        self.collectionView = UICollectionView(
            frame: self.view.bounds,
            collectionViewLayout: layout
        )
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        self.collectionView!.backgroundColor = .black
        registerCells()
        self.view.addSubview(collectionView!)
    }

    private func registerCells() {
        self.collectionView!.register(
            PosterCell.self,
            forCellWithReuseIdentifier: PosterCell.identifier
        )
        self.collectionView!.register(
            ContentCell.self,
            forCellWithReuseIdentifier: ContentCell.identifier
        )
        self.collectionView!.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderView.identifier
        )
        self.collectionView!.register(
            PosterPageControl.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: PosterPageControl.identifier)
    }
}

extension HomeViewController {
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        switch sectionIndex {
        case 0:
            return posterSection()
        case 1:
            return contentSection(weightConstant: sectionIndex)
        case 2:
            return contentSection(weightConstant: sectionIndex)
        case 3:
            return contentSection(weightConstant: sectionIndex)
        default:
            return contentSection(weightConstant: 0)
        }
    }

    func posterSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.7)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(50)
        )
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 10,
            trailing: 0
        )
        section.boundarySupplementaryItems = [
            footer
        ]
        section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
            guard let self = self else { return }
            let page = round(offset.x / self.view.bounds.width)
            self.pagingInfoSubject.send(Int(page))
        }
        return section
    }

    private func contentSection(
        weightConstant: Int 
    ) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.25),
            heightDimension: .fractionalHeight(0.2)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(170)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.interItemSpacing = .fixed(8)

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8.0
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 12,
            bottom: 0,
            trailing: 0
        )
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [
            sectionHeader
        ]
        return section
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.identifier,
                for: indexPath
            ) as! HeaderView
            headerView.titleLabel.text = MockData.title[indexPath.section - 1]
            headerView.titleLabel.textColor = .white
            return headerView
        } else if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: PosterPageControl.identifier,
                for: indexPath
            ) as! PosterPageControl
            footerView.bind(
                pagingInfoSubject: pagingInfoSubject,
                section: indexPath.section
            )
            return footerView
        } else {
            return UICollectionReusableView()
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch section {
        case 0:
            return 5
        case 1:
            return 5
        case 2:
            return 5
        case 3:
            return 5
        default:
            return 0
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        if indexPath.section == 0 {
            guard let posterCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PosterCell.identifier,
                for: indexPath
            ) as? PosterCell
            else { return UICollectionViewCell() }
            posterCell.bindData(MockData.poster[indexPath.row])
            cell = posterCell
        } else {
            guard let contentCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ContentCell.identifier,
                for: indexPath
            ) as? ContentCell
            else { return UICollectionViewCell() }
            contentCell.bindData(
                image: MockData.contents[indexPath.row].0,
                title: MockData.contents[indexPath.row].1
            )
            cell = contentCell
        }
        return cell
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let navigationBarHidden = scrollView.contentOffset.y > 0
        self.navigationController?.setNavigationBarHidden(navigationBarHidden, animated: false)
        self.tabHeaderView.backgroundColor = navigationBarHidden ? .tvingBlack : .clear
        self.navigationItemHiddenView.isHidden = !navigationBarHidden
    }
}
