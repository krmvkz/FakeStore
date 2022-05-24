//
//  ItemViewController.swift
//  FakeStore
//
//  Created by Arman Karimov on 21.05.2022.
//

import UIKit
import SnapKit
import Kingfisher

class ItemViewController: UIViewController {
    
    // MARK: - ViewModels
    var itemVM = ItemViewModel()
    var spinnerVM = SpinnerViewModel()

    // MARK: - Properties
    var id: Int = 0
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        view.backgroundColor = .yellow
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        itemVM.getProduct(by: id)
    }
    
    func setupProtocolConformance() {
        itemVM.delegate = self
    }
    
    func setupView() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(view.width * 0.3)
        }
        titleLabel.snp.makeConstraints { make in
            make.firstBaseline.equalTo(imageView.snp.lastBaseline)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(50)
        }
    }
    
    func updateView(with model: Product) {
        imageView.kf.setImage(with: URL(string: model.image))
        titleLabel.text = model.title
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
