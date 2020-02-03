//
//  UIView+Extension.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 31/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
    }
}
