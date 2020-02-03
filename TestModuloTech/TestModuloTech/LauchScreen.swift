//
//  LauchScreen.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 28/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class LaunchScreen: UIViewController, NVActivityIndicatorViewable {
    
    let loader: NVActivityIndicatorView = {
        let frame = CGRect(x: 0, y: 0, width: 65, height: 65)
        let loader = NVActivityIndicatorView(frame: frame, type: .ballScaleRippleMultiple, color: .black, padding: 6)
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    override func viewDidLoad() {
        initView()
        self.fetchData()
    }
    
    private func initView() {
        view.backgroundColor = .white
        view.addSubview(loader)
        setConstraint()
        loader.startAnimating()
    }
    
    private func fetchData() {
        DataFetcher.shared.fetch { (result) in
            switch result {
            case .Error(let err, let stack):
                print(err)
                if let stack = stack {
                    print(stack)
                }
            case .Success(_, _):
                self.saveData()
                self.loader.stopAnimating()
                let homePage = HomePage()
                self.navigationController?.pushViewController(homePage, animated: false)
                self.navigationController?.isNavigationBarHidden = false
            }
        }
    }
    
    private func setConstraint() {
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func saveData() {
        DbManager.shared.saveData()
    }
}
