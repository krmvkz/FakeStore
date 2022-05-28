//
//  CartViewController.swift
//  FakeStore
//
//  Created by Arman Karimov on 17.05.2022.
//

import UIKit

final class CartViewController: UIViewController {
    
    // MARK: - ViewModels
    private var cartVM = CartViewModel()
    
    // MARK: - Properties
    private lazy var cartItemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    private lazy var checkoutButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Checkout", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemPink
        btn.layer.cornerRadius = 4
        btn.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        return btn
    }()
    private lazy var noItemsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemBackground.inverted
        imageView.image = UIImage(systemName: "rectangle.on.rectangle.slash.fill")
        return imageView
    }()
    

    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProtocolConformance()
        initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cartVM.fetchCartItems()
        checkForItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupView()
    }
    

}

// MARK: - Private Methods
private extension CartViewController {
    
    func initialSetup() {
        view.backgroundColor = .systemBackground
        view.addSubview(cartItemsCollectionView)
        view.addSubview(checkoutButton)
        view.addSubview(noItemsImageView)
    }
    
    func setupProtocolConformance() {
        cartItemsCollectionView.dataSource = self
        cartItemsCollectionView.delegate = self
        cartVM.delegate = self
    }
    
    func setupView() {
        cartItemsCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(70)
            make.leading.trailing.equalTo(view).inset(10)
        }
        checkoutButton.snp.makeConstraints { make in
            make.top.equalTo(cartItemsCollectionView.snp.bottom).inset(-10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalTo(view).inset(40)
        }
        noItemsImageView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.height.width.equalTo(100)
        }
    }
    
    @objc func showAlert() {
        let message = "You are ordering \(cartVM.totalItems()) products, of total price: \(cartVM.totalPrice()). Are you sure want to continue?"
        let alert = UIAlertController(title: "Order", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { [self] _ in
            cartVM.deleteAll()
            DispatchQueue.main.async {
                checkForItems()
                cartItemsCollectionView.reloadData()
            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
//                self.checkForItems()
//                self.
//            })
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkForItems() {
        if cartVM.totalItems() == 0 {
            cartItemsCollectionView.isHidden = true
            checkoutButton.isHidden = true
            noItemsImageView.isHidden = false
        } else {
            cartItemsCollectionView.isHidden = false
            checkoutButton.isHidden = false
            noItemsImageView.isHidden = true
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CartViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartVM.cartItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = cartVM.cartItems[indexPath.row] as! CartItem
        cell.setupCell(with: item)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CartViewController: UICollectionViewDelegateFlowLayout {
        
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.width, height: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.width, height: 5)
    }
    
    
}

// MARK: - CartViewModelDelegate
extension CartViewController: CartViewModelDelegate {
    
    func didFinishFetchingItems() {
        DispatchQueue.main.async {
            self.checkForItems()
            self.cartItemsCollectionView.reloadData()
        }
    }
    
}


// MARK: - Preview Extension
#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct CartVC: PreviewProvider {

    static var previews: some View {
        CartViewController().toPreview()
    }
}
#endif
