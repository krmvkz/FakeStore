//
//  CartViewController.swift
//  FakeStore
//
//  Created by Arman Karimov on 17.05.2022.
//

import UIKit

final class CartViewController: UIViewController {

    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }

}

// MARK: - Private Methods
private extension CartViewController {
    
    func initialSetup() {
        view.backgroundColor = .systemBackground
    }
    
}

// MARK: - Preview Extension
#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct CartVC: PreviewProvider {

    static var previews: some View {
        CartViewController().toPreview()
    }
}
#endif
