//
//  HomeViewController.swift
//  FakeStore
//
//  Created by Arman Karimov on 17.05.2022.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    
    // MARK: - ViewModels
    let homeVM = HomeViewModel()
    let spinnerVM = SpinnerViewModel()
    
    // MARK: - Properties
    private var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProtocolConformance()
        initialSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        homeVM.startTimerForAutoScroll(collectionView: homeCollectionView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        homeVM.stopTimer()
    }
    
}

// MARK: - Private Methods
private extension HomeViewController {
    
    func initialSetup() {
        view.backgroundColor = .systemBackground
        view.addSubview(homeCollectionView)
    }
    
    func setupProtocolConformance() {
        homeCollectionView.dataSource = self
        homeCollectionView.delegate = self
    }
    
    func setupView() {
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        homeCollectionView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(self.view.width * (3/4))
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeVM.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        let arr = homeVM.collectionContent[indexPath.row]
        let image = arr.key
        let content = arr.value
        cell.setupCell(with: image ?? UIImage(), content: content)
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return homeVM.sizeForItemAt(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeVM.showCatalogue(from: self)
    }
    
}

// MARK: - Preview Extension
#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct HomeVC: PreviewProvider {

    static var previews: some View {
        HomeViewController().toPreview()
    }
}
#endif
