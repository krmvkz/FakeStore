//
//  ItemViewController.swift
//  FakeStore
//
//  Created by Arman Karimov on 21.05.2022.
//

import UIKit
import Kingfisher

class ItemViewController: UIViewController {
    
    // MARK: - ViewModels
    var itemVM = ItemViewModel()
    var spinnerVM = SpinnerViewModel()

    // MARK: - Properties
    var id: Int = 0
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProtocolConformance()
        initialSetup()
    }
    
    override func viewDidLayoutSubviews() {
        setupView()
    }

}

// MARK: - Methods
private extension ItemViewController {
    
    func initialSetup() {
        view.backgroundColor = .systemBackground
        itemVM.getProduct(by: id)
    }
    
    func setupProtocolConformance() {
        itemVM.delegate = self
    }
    
    func setupView() {
    // TODO: - add constraints
    }
    
    func updateView(with model: Product) {
        imageView.kf.setImage(with: URL(string: model.image))
        titleLabel.text = model.title
    }
    
}

// MARK: ItemViewModelDelegate
extension ItemViewController: ItemViewModelDelegate {
    
    func didStarFetchingItem() {
        spinnerVM.createSpinnerView(in: self)
    }
    
    func didFinishFetchingItem(with result: Result<Product, Error>) {
        switch result {
        case .success(let data):
            updateView(with: data)
            spinnerVM.removeSpinnerView()
        case .failure(let error):
            spinnerVM.removeSpinnerView()
            print(error)
            fatalError()
        }
    }
    
}
