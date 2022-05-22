//
//  UIVIew+Preview.swift
//  FakeStore
//
//  Created by Arman Karimov on 21.05.2022.
//

import UIKit

#if DEBUG
import SwiftUI

@available(iOS 13, *)
extension UIView {
    
    // enable preview for UIKit
    @available(iOS 13, *)
    private struct Preview: UIViewRepresentable {
        typealias UIViewType = UIView
        let view: UIView
        func makeUIView(context: Context) -> UIView {
            return view
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {
            //
        }
    }

    func showPreview() -> some View {
        // inject self (the current UIView) for the preview
        Preview(view: self)
    }
}

#endif
