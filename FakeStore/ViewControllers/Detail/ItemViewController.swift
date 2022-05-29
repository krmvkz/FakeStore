//
//  ItemViewController.swift
//  FakeStore
//
//  Created by Arman Karimov on 21.05.2022.
//

import UIKit
import SnapKit
import Kingfisher

final class ItemViewController: UIViewController {
    
    // MARK: - ViewModels
    var itemVM = ItemViewModel()
    var cartVM = CartViewModel()
    var spinnerVM = SpinnerViewModel()
    var item: Product?

    // MARK: - Properties
    var id: Int = 0
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    lazy var addToCartButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add to cart", for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .systemPink
        btn.layer.cornerRadius = 4
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(pressedAddToCart), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProtocolConformance()
        initialSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupView()
    }
    
}

// MARK: - Methods
private extension ItemViewController {
    
    func initialSetup() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)
        view.addSubview(addToCartButton)
        itemVM.getProduct(by: id)
    }
    
    func setupProtocolConformance() {
        itemVM.delegate = self
    }
    
    func setupView() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(view.height * 0.5)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(-10)
            make.leading.trailing.equalTo(view).inset(10)
            make.height.equalTo(50)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-10)
            make.leading.trailing.equalTo(view).inset(10)
            make.height.equalTo(25)
        }
        addToCartButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.leading.trailing.equalTo(view).inset(40)
            make.height.equalTo(50)
        }
    }
    
    func updateView(with model: Product) {
        imageView.kf.setImage(with: URL(string: model.image))
        titleLabel.text = model.title
        priceLabel.text = "\(model.price)$"
    }
    
    @objc func pressedAddToCart(sender: UIButton) {
        if let item = item {
            let cartItem: CartItemModel = CartItemModel(category: item.category, id: Int64(item.id), image: item.image, price: item.price, title: item.title)
            cartVM.save(cartItem: cartItem)
        }
        sender.backgroundColor = .systemBlue
        sender.isEnabled = false
        sender.setTitle("In the cart", for: .disabled)
        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { (timer) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

// MARK: ItemViewModelDelegate
extension ItemViewController: ItemViewModelDelegate {
    
    func didStartFetchingItem() {
        spinnerVM.createSpinnerView(in: self)
    }
    
    func didFinishFetchingItem(with result: Result<Product, Error>) {
        switch result {
        case .success(let data):
            updateView(with: data)
            item = data
            spinnerVM.removeSpinnerView()
        case .failure(let error):
            spinnerVM.removeSpinnerView()
            print(error)
            fatalError()
        }
    }
    
}

// MARK: - Preview Extension
#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct ItemVC: PreviewProvider {

    static var previews: some View {
        ItemViewController().toPreview()
    }
}
#endif
