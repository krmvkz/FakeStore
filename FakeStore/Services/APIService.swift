//
//  APIService.swift
//  FakeStore
//
//  Created by Arman Karimov on 17.05.2022.
//

import Foundation
import Alamofire

private struct Constants {
    static let baseURL = "https://fakestoreapi.com/products"
}

struct APIService {
    
    // MARK: - Shared instance
    static let shared = APIService()
    
    // MARK: - Methods
    func fetchCategories(completion: @escaping ([String]?, Error?) -> Void) {
        let url = Constants.baseURL + "/categories"
        AF.request(url, method: .get).responseDecodable(of: [String].self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func fetchProductsByCategory(name: String, completion: @escaping ([Product]?, Error?) -> Void) {
        let url = Constants.baseURL + "/category/" + name.replacingOccurrences(of: " ", with: "%20")
        print(url)
        AF.request(url, method: .get).responseDecodable(of: [Product].self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func fetchProduct(by id: Int, completion: @escaping (Product?, Error?) -> Void) {
        let url = Constants.baseURL + "/\(id)"
        print(url)
        AF.request(url, method: .get).responseDecodable(of: Product.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
