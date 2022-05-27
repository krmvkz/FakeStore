//
//  CatalogueViewController.swift
//  FakeStore
//
//  Created by Arman Karimov on 17.05.2022.
//

import UIKit
import SnapKit

final class CatalogueViewController: UIViewController {
    
    // MARK: - ViewModels
    private var catalogueVM = CatalogueViewModel()
    private var spinnerVM = SpinnerViewModel()
    
    // MARK: - Properties
    private var categories: [String] = []
    
    private lazy var categoriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.handleRefresh),
                                 for: UIControl.Event.valueChanged)
        return refreshControl
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
extension CatalogueViewController {
    
    func initialSetup() {
        title = "Catalogue"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .systemBackground.inverted
        view.backgroundColor = .systemBackground
        
        view.addSubview(categoriesTableView)
        catalogueVM.getAllCategories()
    }
    
    func setupView() {
        categoriesTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        categoriesTableView.refreshControl = refreshControl
    }
    
    func setupProtocolConformance() {
        catalogueVM.delegate = self
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
    }
    
    @objc func handleRefresh() {
        catalogueVM.getAllCategories()
    }
    
}

// MARK: - UITableViewDataSource
extension CatalogueViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    // TODO: - Change to custom cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(categories[indexPath.row])
        return cell
    }
    
}

// MARK: UITableViewDelegate
extension CatalogueViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let radius = cell.contentView.layer.cornerRadius
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductsViewController()
        vc.categoryName = categories[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: - CatalogueViewModelDelegate
extension CatalogueViewController: CatalogueViewModelDelegate {
    
    func didStartFetchingCategories() {
        spinnerVM.createSpinnerView(in: self)
    }
    
    func didFinishFetchingCategories(with result: Result<[String], Error>) {
        switch result {
        case .success(let data):
            self.categories = data
            self.categoriesTableView.reloadData()
            spinnerVM.removeSpinnerView()
            categoriesTableView.refreshControl = .none
        case .failure(let error):
            spinnerVM.removeSpinnerView()
            categoriesTableView.refreshControl = .none
            fatalError(error.localizedDescription)
        }
    }
    
}

// MARK: - Preview Extension
#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct CatalogueVC: PreviewProvider {

    static var previews: some View {
        CatalogueViewController().toPreview()
    }
}
#endif
