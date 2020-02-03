//
//  UIStackView+Extension.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 02/02/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
