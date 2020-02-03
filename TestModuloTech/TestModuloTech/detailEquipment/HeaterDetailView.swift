//
//  HeaterDetailView.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 30/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import UIKit

class HeaterDetailView: UIViewController {
    
    private let heaterViewModel: HeaterViewModel
    
    private var subscriberId: Int?
    
    private let paddingConstant: CGFloat = 20
    private let alphaColor: CGFloat = 0.8
    
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
        imageView.image = ImageUtils.getBigImage(fromDiviceType: .Heater, withMode: self.heaterViewModel.heater.mode)
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
    
    private lazy var powerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(alphaColor)
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var temperatureView: UIView = {
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
        textField.text = self.heaterViewModel.heater.deviceName
        textField.sizeToFit()
        textField.font = .systemFont(ofSize: 16, weight: .thin)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Nom de l'équipement"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var powerLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.text = "Etat: "
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var powerToggle: UISwitch = {
        let toggleBtn = UISwitch()
        toggleBtn.isOn = self.heaterViewModel.heater.mode
        toggleBtn.translatesAutoresizingMaskIntoConstraints = false
        return toggleBtn
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "Température: \(self.heaterViewModel.heater.temperature)°C"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var temperatureSlider: UIStepper = {
        let slider = UIStepper()
        slider.minimumValue = 7
        slider.maximumValue = 28
        slider.stepValue = 0.5
        slider.value = Double(self.heaterViewModel.heater.temperature)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    init(with viewModel: HeaterViewModel) {
        heaterViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        self.navigationItem.title = heaterViewModel.heater.deviceName
        subscriberId = heaterViewModel.subscribe(self)
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
        heaterViewModel.unsubscribe(subscriberId)
    }
    
    private func updateUI() {
        let name = heaterViewModel.heater.deviceName
        let mode = heaterViewModel.heater.mode
        let temperature = heaterViewModel.heater.temperature
        self.navigationItem.title = name
        imageView.image = ImageUtils.getBigImage(fromDiviceType: .Heater, withMode: mode)
        powerToggle.isOn = mode
        nameTextField.text = name
        self.navigationItem.title = name
        temperatureSlider.value = Double(temperature)
        temperatureLabel.text = "Température \(temperature)°C"
    }
    
    @objc func sliding(_ sender: UIStepper) {
        if sender.isTracking {
            temperatureLabel.text = "Température: \(sender.value)°C"
            return
        }
        heaterViewModel.changeTemperature(Int16(sender.value))
    }
    
    @objc func switching(_ sender: UISwitch) {
        heaterViewModel.changeMode(sender.isOn)
    }
    
    private func setActions() {
        temperatureSlider.addTarget(self, action: #selector(self.sliding(_:)), for: .valueChanged)
        powerToggle.addTarget(self, action: #selector(self.switching(_:)), for: .valueChanged)
    }
    
    private func setView() {
    
        backgroundImage.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: paddingConstant).isActive = true
        imageView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -paddingConstant).isActive = true
        imageView.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor).isActive = true
        
        
        powerView.addSubview(powerLabel)
        powerView.addSubview(powerToggle)
        
        powerLabel.topAnchor.constraint(equalTo: powerView.topAnchor, constant: paddingConstant).isActive = true
        powerLabel.leadingAnchor.constraint(equalTo: powerView.leadingAnchor, constant: 20).isActive = true
        powerLabel.bottomAnchor.constraint(equalTo: powerView.bottomAnchor, constant: -paddingConstant).isActive = true
        
        powerToggle.topAnchor.constraint(equalTo: powerView.topAnchor, constant: paddingConstant).isActive = true
        powerToggle.trailingAnchor.constraint(equalTo: powerView.trailingAnchor, constant: -paddingConstant).isActive = true
        powerToggle.bottomAnchor.constraint(equalTo: powerView.bottomAnchor, constant: -paddingConstant).isActive = true
        
        
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

        
        temperatureView.addSubview(temperatureLabel)
        temperatureView.addSubview(temperatureSlider)

        temperatureLabel
            .topAnchor
            .constraint(equalTo: temperatureView.topAnchor, constant: paddingConstant)
            .isActive = true
        temperatureLabel
            .leadingAnchor
            .constraint(equalTo: temperatureView.leadingAnchor, constant: paddingConstant)
            .isActive = true
        temperatureLabel
            .bottomAnchor
            .constraint(equalTo: temperatureView.bottomAnchor, constant: -paddingConstant)
            .isActive = true

        temperatureSlider
            .centerYAnchor
            .constraint(equalTo: temperatureView.centerYAnchor)
            .isActive = true
        temperatureSlider
            .leadingAnchor
            .constraint(equalTo: temperatureLabel.trailingAnchor, constant: paddingConstant)
            .isActive = true
        let trailingTemperatureSlider =
        temperatureSlider
            .trailingAnchor
            .constraint(equalTo: temperatureView.trailingAnchor, constant: -paddingConstant)
        trailingTemperatureSlider.priority = UILayoutPriority(rawValue: 750)
        trailingTemperatureSlider.isActive = true
        
        
        view.addSubview(backgroundViewImage)
        backgroundViewImage.addSubview(stackView)
        
        backgroundViewImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundViewImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundViewImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundViewImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        stackView.addArrangedSubview(backgroundImage)
        stackView.addArrangedSubview(powerView)
        stackView.addArrangedSubview(nameView)
        stackView.addArrangedSubview(temperatureView)
    
        stackView.leadingAnchor.constraint(equalTo: backgroundViewImage.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: backgroundViewImage.trailingAnchor, constant: -30).isActive = true
        stackView.centerXAnchor.constraint(equalTo: backgroundViewImage.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: backgroundViewImage.centerYAnchor).isActive = true
        stackView.sizeToFit()
        stackView.layoutIfNeeded()
    }
}

extension HeaterDetailView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        heaterViewModel.changeDeviceName(textField.text ?? "")
    }
}

extension HeaterDetailView: MyObserver {
    func valueChange() {
        self.updateUI()
    }
}
