//
//  ProductCollectionViewCell.swift
//  FakeStore
//
//  Created by Arman Karimov on 20.05.2022.
//

import UIKit
import SnapKit
import Kingfisher


final class ProductCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Static Properties
    static let identifier = "ProductCollectionViewCell"
    
    // MARK: - UI Init
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        self.dropShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 5,
                                  y: contentView.height-50,
                                  width: contentView.width-10,
                                  height: 50)
        imageView.frame = CGRect(x: 10,
                                 y: 5,
                                 width: contentView.width-20,
                                 height: contentView.height-60)
    }
    
}

// MARK: - Methods
extension ProductCollectionViewCell {
    
    func setupCell(with product: Product) {
        if let url = URL(string: product.image) {
            imageView.kf.setImage(with: url)
        }
        titleLabel.text = product.title
    }
    
}
