//
//  HomeViewModel.swift
//  FakeStore
//
//  Created by Arman Karimov on 17.05.2022.
//

import UIKit

final class HomeViewModel {
    
    // MARK: - Properties
    private var counter = 1
    private var timer = Timer()
    
    var collectionContent: [(key: UIImage?, value: String)] = Array([
        UIImage(named: "home-ci1") : "Sale is Live, Go get your product",
        UIImage(named: "home-ci2") : "Shop right now",
        UIImage(named: "home-ci3") : "Wanna shop?"
    ])
    
    var numberOfItemsInSection: Int {
        return collectionContent.count
    }
    
}

// MARK: - Methods
extension HomeViewModel {
    
    func sizeForItemAt(_ collectionView: UICollectionView) -> CGSize {
        let width = (collectionView.frame.width)
        let height = width * (3/4)
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionViewCGRect(in vc: UIViewController) -> CGRect {
        let width = (vc.view.width)
        let height = width * (3/4)
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        return rect
    }
    
    func startTimerForAutoScroll(collectionView: UICollectionView) {
        let selector = #selector(autoScroll(sender:))
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: selector, userInfo: collectionView, repeats: true)
    }
    
    @objc func autoScroll(sender: Timer) {
        if let collectionView = sender.userInfo as? UICollectionView {
            if self.counter < self.collectionContent.count {
                let indexPath = IndexPath(item: counter, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                counter += 1
            } else {
                counter = 1
                collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    func showCatalogue(from viewController: UIViewController) {
        let vc = CatalogueViewController()
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
   
}
