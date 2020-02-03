//
//  EquipmentCell.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 28/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import Foundation
import UIKit

class EquipmentCell: UICollectionViewCell {
    
    weak var delegate: EquipmentCellDelegate?
    
    var animated = false
    
    lazy var trashView: UIView = {
       let view = UIView()
        view.backgroundColor = .init(red: 1, green: 1, blue: 1, alpha: 0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var trashImageview: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = #imageLiteral(resourceName: "trash")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var name: UILabel = {
        let name = UILabel()
        name.textAlignment = .center
        name.numberOfLines = 2
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCell()
        setActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell() {
        addSubview(stackView)
        stackView
            .topAnchor
            .constraint(equalTo: topAnchor, constant: 20)
            .isActive = true
        stackView
            .leadingAnchor
            .constraint(equalTo: leadingAnchor)
            .isActive = true
        stackView
            .trailingAnchor
            .constraint(equalTo: trailingAnchor)
            .isActive = true
        stackView
            .bottomAnchor
            .constraint(equalTo: bottomAnchor, constant: -20)
            .isActive = true
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(name)
        
        
        name
            .leadingAnchor
            .constraint(equalTo: stackView.leadingAnchor, constant: 30)
            .isActive = true
        name
            .trailingAnchor
            .constraint(equalTo: stackView.trailingAnchor, constant: -30)
            .isActive = true
        
        trashView.addSubview(trashImageview)
        trashImageview
            .centerXAnchor
            .constraint(equalTo: trashView.centerXAnchor)
            .isActive = true
        trashImageview
            .centerYAnchor
            .constraint(equalTo: trashView.centerYAnchor)
            .isActive = true
    }
    
    func setActions()  {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longTap(_:)))
        addGestureRecognizer(longPressGesture)
    }
    
    @objc func press(_ gesture: UIGestureRecognizer) {
        stopAnimation()
    }
    
    @objc func longTap(_ gesture: UIGestureRecognizer) {
        switch gesture.state {
        case .began:
            addTrashView()
            CustomAnimations.shared.shakeOnce(onView: self)
            animated = true
            delegate?.isAnimated(cell: self)
        default:
            break
        }
    }
    
    func stopAnimation() {
        if (animated) {
            trashView.removeFromSuperview()
            CustomAnimations.shared.stopAnimationOnSelf(view: self)
            animated = false
            delegate?.didFinishAnimated(cell: self)
            return
        }
    }
    
    func addTrashView() {
        addSubview(trashView)
        trashView
            .topAnchor
            .constraint(equalTo: topAnchor)
            .isActive = true
        trashView
            .leadingAnchor
            .constraint(equalTo: leadingAnchor)
            .isActive = true
        trashView
            .trailingAnchor
            .constraint(equalTo: trailingAnchor)
            .isActive = true
        trashView
            .bottomAnchor
            .constraint(equalTo: bottomAnchor)
            .isActive = true
    }
}

protocol EquipmentCellDelegate: class {
    func isAnimated(cell: UICollectionViewCell)
    func didFinishAnimated(cell: UICollectionViewCell)
}

