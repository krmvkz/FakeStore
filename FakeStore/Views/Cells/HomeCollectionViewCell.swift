//
//  HomeCollectionViewCell.swift
//  FakeStore
//
//  Created by Arman Karimov on 21.05.2022.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Static Properties
    static let identifier = "HomeCollectionViewCell"
    
    // MARK: - UI Init
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
        self.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.frame = CGRect(x: 10,
                                    y: contentView.height-50,
                                    width: contentView.width-20,
                                    height: 50)
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: contentView.width,
                                 height: contentView.height-50)
        
    }
    
}

extension HomeCollectionViewCell {
    
    func setupCell(with image: UIImage, content: String) {
        imageView.image = image
        contentLabel.text = content
    }
    
}
