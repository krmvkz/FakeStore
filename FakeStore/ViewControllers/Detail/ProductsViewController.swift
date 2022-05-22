//
//  ProductsViewController.swift
//  FakeStore
//
//  Created by Arman Karimov on 20.05.2022.
//

import UIKit
import SnapKit
import Kingfisher

class ProductsViewController: UIViewController {
    
    // MARK: - ViewModels
    var productsVM = ProductsViewModel()
    var spinnerVM = SpinnerViewModel()
    
    // MARK: - Properties
    private var products: [Product] = []
    var categoryName: String = ""
    
    private lazy var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        return collectionView
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

// MARK: - Private Methods
private extension ProductsViewController {
    
    func initialSetup() {
        view.backgroundColor = .systemBackground
        view.addSubview(productsCollectionView)
        
        productsVM.getProductsByCategory(name: categoryName)
    }
    
    func setupView() {
        productsCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self.view).inset(10)
        }
        productsCollectionView.reloadData()
    }
    
    func setupProtocolConformance() {
        productsVM.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
    }
    
}

// MARK: - UICollectionViewDataSource
extension ProductsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupCell(with: products[indexPath.row])
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProductsViewController: UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width/2)-4
        let height = width * (4/3)
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let radius = cell.contentView.layer.cornerRadius
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.width, height: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ItemViewController()
        vc.id = products[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - ProductsViewModelDelegate
extension ProductsViewController: ProductsViewModelDelegate {
    
    func didStartFetchingProducts() {
        print("Did start fetching products")
        spinnerVM.createSpinnerView(in: self)
    }
    
    func didFinishFetchingProducts(with result: Result<[Product], Error>) {
        switch result {
        case .success(let data):
            products = data
            productsCollectionView.reloadData()
            spinnerVM.removeSpinnerView()
        case .failure(let error):
            spinnerVM.removeSpinnerView()
            print(error)
            fatalError()
        }
    }
    
}
