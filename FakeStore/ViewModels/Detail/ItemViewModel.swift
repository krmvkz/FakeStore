//
//  ItemViewModel.swift
//  FakeStore
//
//  Created by Arman Karimov on 21.05.2022.
//

import Foundation

protocol ItemViewModelDelegate: AnyObject {
    func didStarFetchingItem()
    func didFinishFetchingItem(with result: Result<Product, Error>)
}

struct ItemViewModel {
    
    // MARK: - Delegate
    var delegate: ItemViewModelDelegate?

}

// MARK: - Methods
extension ItemViewModel {
    
    func getProduct(by id: Int) {
        delegate?.didStarFetchingItem()
        APIService.shared.fetchProduct(by: id) { [self] item, error in
            if let error = error {
                delegate?.didFinishFetchingItem(with: .failure(error))
            }
            if let data = item {
                DispatchQueue.main.async {
                    delegate?.didFinishFetchingItem(with: .success(data))
                }
            }

        }
    }
    
}
