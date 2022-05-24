//
//  HomeCollectionViewCell.swift
//  FakeStore
//
//  Created by Arman Karimov on 21.05.2022.
//

import UIKit
import SnapKit

final class HomeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Static Properties
    static let identifier = "HomeCollectionViewCell"
    
    // MARK: - UI Init
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(contentLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.width.equalTo(contentView.width-20)
            make.height.equalTo(contentView.height-50)
            make.centerX.equalTo(contentView)
        }
        contentLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView)
            make.height.equalTo(50)
            make.width.equalTo(contentView.width-20)
            make.centerX.equalTo(contentView)
        }
    }
    
}

// MARK: - Methods
extension HomeCollectionViewCell {
    
    func setupCell(with image: UIImage, content: String) {
        imageView.image = image
        contentLabel.text = content
    }
    
}
