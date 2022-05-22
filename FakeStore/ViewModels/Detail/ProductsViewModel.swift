//
//  ProductsViewModel.swift
//  FakeStore
//
//  Created by Arman Karimov on 20.05.2022.
//

import UIKit

protocol ProductsViewModelDelegate: AnyObject {
    func didStartFetchingProducts()
    func didFinishFetchingProducts(with result: Result<[Product], Error>)
}

struct ProductsViewModel {
    
    // MARK: - Delegate
    var delegate: ProductsViewModelDelegate?
    
}

// MARK: - Methods
extension ProductsViewModel {
    
    func getProductsByCategory(name: String) {
        delegate?.didStartFetchingProducts()
            APIService.shared.fetchProductsByCategory(name: name) { [self] data, error in
                if let error = error {
                    delegate?.didFinishFetchingProducts(with: .failure(error))
                    print(error)
                    fatalError(error.localizedDescription)
                }
                if let data = data {
                    delegate?.didFinishFetchingProducts(with: .success(data))
                }
            }
        }
    
}
