//
//  CategoryTableViewCell.swift
//  FakeStore
//
//  Created by Arman Karimov on 20.05.2022.
//

import Foundation
import UIKit
import SnapKit

final class CategoryTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    static let identifier = "CategoryTableViewCell"
    
    lazy var wrapView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(wrapView)
        wrapView.addSubview(categoryNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
}

// MARK: - Methods
extension CategoryTableViewCell {
    
    func setupView() {
        selectionStyle = .none
        contentView.backgroundColor = .clear
        wrapView.dropShadow()
        wrapView.backgroundColor = .systemBackground
        wrapView.layer.cornerRadius = 4
        wrapView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView).inset(5)
            make.leading.trailing.equalTo(contentView).inset(10)
        }
        categoryNameLabel.snp.makeConstraints { make in
            make.edges.equalTo(wrapView).inset(5)
            make.height.equalTo(50)
        }
    }
    
    func setupCell(_ name: String) {
        categoryNameLabel.text = name
    }
    
}
