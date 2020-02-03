//
//  RollerShutterDetailView.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 30/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import UIKit

class RollerShutterDetailView: UIViewController {
    
    private let rollerShutterViewModel: RollerShutterViewModel
    
    private var subscriberId: Int?
    
    private let paddingConstant: CGFloat = 20
    private let alphaColor: CGFloat = 0.8
    
    private lazy var scrollView: UIScrollView = {
        let scroolView = UIScrollView()
        scroolView.translatesAutoresizingMaskIntoConstraints = false
        return scroolView
    }()
    
    private lazy var backgroundViewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "cosy-cottage-ambleside-11")
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var backgroundImage: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.backgroundColor = UIColor.white.withAlphaComponent(alphaColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = ImageUtils.getBigImage(fromDiviceType: .RollerShutter, withPosition: self.rollerShutterViewModel.rollerShutter.position)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(alphaColor)
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var positionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(alphaColor)
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nom: "
        label.sizeToFit()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.text = self.rollerShutterViewModel.rollerShutter.deviceName
        textField.sizeToFit()
        textField.font = .systemFont(ofSize: 16, weight: .thin)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Nom de l'équipement"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.text = "Position: \(self.rollerShutterViewModel.rollerShutter.position)"
        label.sizeToFit()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sliderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var positionSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        slider.value = Float(self.rollerShutterViewModel.rollerShutter.position)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    init(with viewModel: RollerShutterViewModel) {
        rollerShutterViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        self.navigationItem.title = rollerShutterViewModel.rollerShutter.deviceName
        subscriberId = rollerShutterViewModel.subscribe(self)
        view.backgroundColor = Colors.darkWhite
        nameTextField.delegate = self
        setView()
        setActions()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        backgroundViewImage.isHidden = true
    }
    
    deinit {
        rollerShutterViewModel.unsubscribe(subscriberId)
    }
    
    private func updateUI() {
        let name = rollerShutterViewModel.rollerShutter.deviceName
        let position = rollerShutterViewModel.rollerShutter.position
        self.navigationItem.title = name
        imageView.image = ImageUtils.getBigImage(fromDiviceType: .RollerShutter, withPosition: self.rollerShutterViewModel.rollerShutter.position)
        nameTextField.text = name
        self.navigationItem.title = name
        positionSlider.value = Float(position)
        positionLabel.text = "Position: \(self.rollerShutterViewModel.rollerShutter.position)"
    }
    
    @objc func sliding(_ sender: UISlider) {
        if sender.isTracking {
            positionLabel.text = "Position: \(self.rollerShutterViewModel.rollerShutter.position)"
            return
        }
        rollerShutterViewModel.changePosition(Int16(sender.value))
    }
    
    private func setActions() {
        positionSlider.addTarget(self, action: #selector(self.sliding(_:)), for: .valueChanged)
    }
    
    private func setView() {
        
        backgroundImage.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: paddingConstant).isActive = true
        imageView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -paddingConstant).isActive = true
        imageView.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor).isActive = true
        
        
        nameView.addSubview(nameLabel)
        nameView.addSubview(nameTextField)
        
        nameLabel.topAnchor.constraint(equalTo: nameView.topAnchor, constant: paddingConstant).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: paddingConstant).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -paddingConstant).isActive = true
        
        nameTextField.centerYAnchor.constraint(equalTo: nameView.centerYAnchor).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: paddingConstant).isActive = true
        let trailingAnchorNameTF = nameTextField.trailingAnchor.constraint(lessThanOrEqualTo: nameView.trailingAnchor, constant: -paddingConstant)
        trailingAnchorNameTF.priority = UILayoutPriority(rawValue: 750)
        trailingAnchorNameTF.isActive = true
        
        
        positionView.addSubview(positionLabel)
        positionView.addSubview(sliderStackView)
        
        sliderStackView.addArrangedSubview(positionSlider)
        
        positionLabel
            .topAnchor
            .constraint(equalTo: positionView.topAnchor, constant: paddingConstant)
            .isActive = true
        positionLabel
            .leadingAnchor
            .constraint(equalTo: positionView.leadingAnchor, constant: paddingConstant)
            .isActive = true
        
        positionSlider.widthAnchor.constraint(equalTo: sliderStackView.heightAnchor).isActive = true
        positionSlider.centerYAnchor.constraint(equalTo: sliderStackView.centerYAnchor).isActive = true
        positionSlider.leadingAnchor.constraint(equalTo: sliderStackView.leadingAnchor).isActive = true

        positionSlider.trailingAnchor.constraint(equalTo: sliderStackView.trailingAnchor).isActive = true

        
        sliderStackView.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 20).isActive = true
        sliderStackView.leadingAnchor.constraint(equalTo: positionView.leadingAnchor).isActive = true
        sliderStackView.trailingAnchor.constraint(equalTo: positionView.trailingAnchor).isActive = true
        sliderStackView.bottomAnchor.constraint(equalTo: positionView.bottomAnchor).isActive = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundViewImage)
        backgroundViewImage.addSubview(stackView)
        
        scrollView
            .topAnchor
            .constraint(equalTo: view.topAnchor)
            .isActive = true
        scrollView
            .leadingAnchor
            .constraint(equalTo: view.leadingAnchor)
            .isActive = true
        scrollView
            .trailingAnchor
            .constraint(equalTo: view.trailingAnchor)
            .isActive = true
        scrollView
            .bottomAnchor
            .constraint(equalTo: view.bottomAnchor)
            .isActive = true
        
        scrollView.backgroundColor = .white
        scrollView.bounces = false
        
        backgroundViewImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true

        backgroundViewImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        backgroundViewImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        backgroundViewImage.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        backgroundViewImage.isUserInteractionEnabled = true

        stackView.addArrangedSubview(backgroundImage)
        stackView.addArrangedSubview(nameView)
        stackView.addArrangedSubview(positionView)
        
        stackView.leadingAnchor.constraint(equalTo: backgroundViewImage.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: backgroundViewImage.trailingAnchor, constant: -30).isActive = true
        stackView.centerXAnchor.constraint(equalTo: backgroundViewImage.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: backgroundViewImage.bottomAnchor, constant: -30).isActive = true
        stackView.topAnchor.constraint(equalTo: backgroundViewImage.topAnchor, constant: 30).isActive = true

        stackView.sizeToFit()
        stackView.layoutIfNeeded()
    }
    
}

extension RollerShutterDetailView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        rollerShutterViewModel.changeDeviceName(textField.text ?? "")
    }
}

extension RollerShutterDetailView: MyObserver {
    func valueChange() {
        self.updateUI()
    }
}
