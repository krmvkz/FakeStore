//
//  SpinnerViewModel.swift
//  FakeStore
//
//  Created by Arman Karimov on 19.05.2022.
//

import UIKit

struct SpinnerViewModel {
    
    let child = SpinnerViewController()
    
}

// MARK: - Methods
extension SpinnerViewModel {
    
    func createSpinnerView(in vc: UIViewController) {
        vc.addChild(child)
        child.view.frame = vc.view.frame
        vc.view.addSubview(child.view)
        child.didMove(toParent: vc)
        debugPrint("Spinner animating")
    }
    
    func removeSpinnerView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
            debugPrint("Spinner stopped")
        }
    }
    
}
