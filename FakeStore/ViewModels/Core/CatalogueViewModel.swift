//
//  CatalogueViewModel.swift
//  FakeStore
//
//  Created by Arman Karimov on 17.05.2022.
//

import Foundation
import UIKit

protocol CatalogueViewModelDelegate: AnyObject {
    func didStartFetchingCategories()
    func didFinishFetchingCategories(with result: Result<[String], Error>)
}

struct CatalogueViewModel {
    
    // MARK: - Delegate
    weak var delegate: CatalogueViewModelDelegate?
    
}

// MARK: - Methods
extension CatalogueViewModel {
    
    func getAllCategories() {
        delegate?.didStartFetchingCategories()
        APIService.shared.fetchCategories { [self] data, error in
            if let error = error {
                delegate?.didFinishFetchingCategories(with: .failure(error))
                fatalError(error.localizedDescription)
            }
            if let data = data {
                delegate?.didFinishFetchingCategories(with: .success(data))
            }
        }
    }
    
}


