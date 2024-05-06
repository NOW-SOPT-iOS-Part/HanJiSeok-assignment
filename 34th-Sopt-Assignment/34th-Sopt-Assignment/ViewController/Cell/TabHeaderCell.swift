//
//  TabHeaderCell.swift
//  34th-Sopt-Assignment
//
//  Created by 한지석 on 4/29/24.
//

import UIKit

protocol TabCollectionViewCellDelegate: AnyObject {
    func titleButtonTapped(_ cell: TabHeaderCell)
}

final class TabHeaderCell: UICollectionViewCell {
    
    static let identifier = "TabHeaderCell"

    weak var delegate: TabCollectionViewCellDelegate?
    
    let titleButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.setTitleColor(.black, for: .selected)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 17)
        return button
    }()
    
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        contentView.addSubview(titleButton)
        contentView.addSubview(underlineView)
        titleButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        print(#function)
        delegate?.titleButtonTapped(self)
    }
    
    func bindData(
        title: String,
        color: UIColor,
        underlineColor: UIColor
    ) {
        self.titleButton.setTitle(title, for: .normal)
        self.titleButton.setTitleColor(color, for: .normal)
        self.underlineView.backgroundColor = underlineColor
    }
    
    func underlineConstraints(cgSize: CGSize) {
        underlineView.snp.makeConstraints {
            $0.top.equalTo(titleButton.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.width.equalTo(cgSize.width)
            $0.height.equalTo(2)
        }
    }
}
