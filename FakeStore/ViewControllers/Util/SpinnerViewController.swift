//
//  SpinnerViewController.swift
//  FakeStore
//
//  Created by Arman Karimov on 19.05.2022.
//

import UIKit
import SnapKit

class SpinnerViewController: UIViewController {

    var spinner = UIActivityIndicatorView.init(style: .large)

    override func loadView() {
        view = UIView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

}
