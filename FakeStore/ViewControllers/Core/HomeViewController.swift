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
    var counter = 1
    var timer = Timer()
    private var collectionContent: [UIImage? : String] = [
        UIImage(named: "home-ci1") : "Sale is Live, Go get your product",
        UIImage(named: "home-ci2") : "Shop right now",
        UIImage(named: "home-ci3") : "Wanna shop?"
    ]
    
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
        startTimerForAutoScroll()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
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
        view.translatesAutoresizingMaskIntoConstraints = false
        homeCollectionView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(self.view.width * (3/4))
        }
    }
    
    func startTimerForAutoScroll() {
         timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll() {
        if self.counter < self.collectionContent.count {
          let indexPath = IndexPath(item: counter, section: 0)
          self.homeCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
          self.counter += 1
        } else {
          self.counter = 1
          self.homeCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
}

extension HomeViewController: UICollectionViewDataSource {

    // TODO: Change from mock data
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        let arr = Array(collectionContent)[indexPath.row]
        let image = arr.key
        let content = arr.value
        cell.setupCell(with: image ?? UIImage(), content: content)
//        cell.backgroundColor = .red
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width)
        let height = width * (3/4)
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CatalogueViewController()
//        self.navigationController?.show(vc, sender: nil)
        self.navigationController?.pushViewController(vc, animated: true)
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
