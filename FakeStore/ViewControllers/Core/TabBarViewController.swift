//
//  TabBarViewController.swift
//  FakeStore
//
//  Created by Arman Karimov on 17.05.2022.
//

import UIKit

final class TabBarViewController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tabBar.tintColor = .systemBackground.inverted
    }

}

// MARK: - Private Methods
private extension TabBarViewController {
    
    func initialSetup() {
        let vc1 = HomeViewController()
        let vc2 = CatalogueViewController()
        let vc3 = CartViewController()
        let vc4 = FavouritesViewController()

        vc1.title = "Home"
        vc2.title = "Catalogue"
        vc3.title = "Cart"
        vc4.title = "Favourites"

        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)

        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "fk-logo"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Catalogue", image: UIImage(systemName: "magnifyingglass.circle"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "heart"), tag: 4)

        /// TabBarItem selected state
        nav2.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        nav3.tabBarItem.selectedImage = UIImage(systemName: "cart.fill")
        nav4.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")

        setViewControllers([nav1, nav2, nav3, nav4], animated: false)
    }
    
}

// MARK: - Preview Extension
#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct TabBarVC: PreviewProvider {

    static var previews: some View {
        TabBarViewController().toPreview()
    }
    
}
#endif
