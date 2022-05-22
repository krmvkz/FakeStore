//
//  FavouritesViewController.swift
//  FakeStore
//
//  Created by Arman Karimov on 17.05.2022.
//

import UIKit

final class FavouritesViewController: UIViewController {

    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }

}

// MARK: - Private Methods
private extension FavouritesViewController {
    
    func initialSetup() {
        view.backgroundColor = .systemBackground
    }
    
}

// MARK: - Preview Extension
#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct FavouritesVC: PreviewProvider {

    static var previews: some View {
        FavouritesViewController().toPreview()
    }
}
#endif
