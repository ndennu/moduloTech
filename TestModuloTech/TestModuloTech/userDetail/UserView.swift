//
//  UserView.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 01/02/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import UIKit

class UserView: UIViewController {
    
    private(set) var userViewModel = UserViewModel()
    private let alphaColor: CGFloat = 0.8
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = Colors.darkWhite
        scrollView.scrollsToTop = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.distribution = .fill
        stackview.spacing = 12
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private lazy var firstNameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(alphaColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var lastNameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(alphaColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var birthdateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(alphaColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var streetCodeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(alphaColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var streetView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(alphaColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cityView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(alphaColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var postalCodeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(alphaColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var countryView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(alphaColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Prénom: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var firstNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.text = self.userViewModel.user?.firstName
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Prénom"
        textfield.font = .systemFont(ofSize: 16, weight: .thin)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        textfield.delegate = self
        return textfield
    }()
    
    private lazy var lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nom de famille: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lastNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.text = self.userViewModel.user?.lastName
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Nom de famille"
        textfield.font = .systemFont(ofSize: 16, weight: .thin)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.delegate = self
        return textfield
    }()
    
    private lazy var birthdateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date de naissance: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var birthdateTextField: UITextField = {
        let textfield = UITextField()
        textfield.text = self.userViewModel.user?.birthDate.toString()
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "jj/mm/aaaa"
        textfield.font = .systemFont(ofSize: 16, weight: .thin)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.delegate = self
        return textfield
    }()
    
    private lazy var streetCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "N° de rue: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var streetCodeTextField: UITextField = {
        let textfield = UITextField()
        textfield.text = self.userViewModel.user?.address.streetCode
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "N° de rue: "
        textfield.font = .systemFont(ofSize: 16, weight: .thin)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.delegate = self
        return textfield
    }()
    
    private lazy var streetLabel: UILabel = {
        let label = UILabel()
        label.text = "Rue: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var streetTextField: UITextField = {
        let textfield = UITextField()
        textfield.text = self.userViewModel.user?.address.street
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Rue"
        textfield.font = .systemFont(ofSize: 16, weight: .thin)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.delegate = self
        return textfield
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Ville: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cityTextField: UITextField = {
        let textfield = UITextField()
        textfield.text = self.userViewModel.user?.address.city
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Ville"
        textfield.font = .systemFont(ofSize: 16, weight: .thin)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.delegate = self
        return textfield
    }()
    
    private lazy var postalCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Code postal: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postalCodeTextField: UITextField = {
        let textfield = UITextField()
        if let code = self.userViewModel.user?.address.postalCode {
            textfield.text = "\(code)"
        }
        
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "ex: 75002"
        textfield.keyboardType = .numberPad
        textfield.font = .systemFont(ofSize: 16, weight: .thin)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.delegate = self
        return textfield
    }()
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = "Pays: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countryTextField: UITextField = {
        let textfield = UITextField()
        textfield.text = self.userViewModel.user?.address.country
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Pays"
        textfield.font = .systemFont(ofSize: 16, weight: .thin)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.delegate = self
        return textfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(onSaveClick))
        setView()
    }
    
    @objc func onSaveClick() {
        
        var postalCode: Int? = nil
        
        if let stringCode = postalCodeTextField.text,
            let code = Int(stringCode) {
            postalCode = code
        }
        
        userViewModel.updateUser(firstname: firstNameTextField.text, lastName: lastNameTextField.text, birthdate: birthdateTextField.text, streetCode: streetTextField.text, street: streetTextField.text, city: cityTextField.text, postCode: postalCode, country: countryTextField.text)
    }
    
    private func setView() {
        var anchor: NSLayoutConstraint
        
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(stackView)
        
        firstNameView.addSubview(firstNameLabel)
        firstNameView.addSubview(firstNameTextField)

        lastNameView.addSubview(lastNameLabel)
        lastNameView.addSubview(lastNameTextField)
        
        birthdateView.addSubview(birthdateLabel)
        birthdateView.addSubview(birthdateTextField)

        streetCodeView.addSubview(streetCodeLabel)
        streetCodeView.addSubview(streetCodeTextField)
        
        streetView.addSubview(streetLabel)
        streetView.addSubview(streetTextField)

        cityView.addSubview(cityLabel)
        cityView.addSubview(cityTextField)
        
        postalCodeView.addSubview(postalCodeLabel)
        postalCodeView.addSubview(postalCodeTextField)

        countryView.addSubview(countryLabel)
        countryView.addSubview(countryTextField)
        
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
        
        backgroundView
            .centerXAnchor
            .constraint(equalTo: scrollView.centerXAnchor)
            .isActive = true
        backgroundView
            .widthAnchor
            .constraint(equalTo: scrollView.widthAnchor)
            .isActive = true
        backgroundView
            .topAnchor
            .constraint(equalTo: scrollView.topAnchor)
            .isActive = true
        backgroundView
            .bottomAnchor
            .constraint(equalTo: scrollView.bottomAnchor)
            .isActive = true
        
        firstNameLabel
            .topAnchor
            .constraint(equalTo: firstNameView.topAnchor, constant: 20)
            .isActive = true
        firstNameLabel
            .leadingAnchor
            .constraint(equalTo: firstNameView.leadingAnchor, constant: 20)
            .isActive = true
        firstNameLabel
            .bottomAnchor
            .constraint(equalTo: firstNameView.bottomAnchor, constant: -20)
            .isActive = true

        firstNameTextField
            .centerYAnchor
            .constraint(equalTo: firstNameView.centerYAnchor)
            .isActive = true
        firstNameTextField
            .leadingAnchor
            .constraint(equalTo: firstNameLabel.trailingAnchor, constant: 20)
            .isActive = true
        anchor = firstNameTextField
            .trailingAnchor
            .constraint(lessThanOrEqualTo: firstNameView.trailingAnchor, constant: -20)
        anchor.priority = UILayoutPriority(750)
        anchor.isActive = true

        lastNameLabel
            .topAnchor
            .constraint(equalTo: lastNameView.topAnchor, constant: 20)
            .isActive = true
        lastNameLabel
            .leadingAnchor
            .constraint(equalTo: lastNameView.leadingAnchor, constant: 20)
            .isActive = true
        lastNameLabel
            .bottomAnchor
            .constraint(equalTo: lastNameView.bottomAnchor, constant: -20)
            .isActive = true

        lastNameTextField
            .centerYAnchor
            .constraint(equalTo: lastNameView.centerYAnchor)
            .isActive = true
        lastNameTextField
            .leadingAnchor
            .constraint(equalTo: lastNameLabel.trailingAnchor, constant: 20)
            .isActive = true
        anchor = lastNameTextField
            .trailingAnchor
            .constraint(lessThanOrEqualTo: lastNameView.trailingAnchor, constant: -20)
        anchor.priority = UILayoutPriority(750)
        anchor.isActive = true
        
        birthdateLabel
            .topAnchor
            .constraint(equalTo: birthdateView.topAnchor, constant: 20)
            .isActive = true
        birthdateLabel
            .leadingAnchor
            .constraint(equalTo: birthdateView.leadingAnchor, constant: 20)
            .isActive = true
        birthdateLabel
            .bottomAnchor
            .constraint(equalTo: birthdateView.bottomAnchor, constant: -20)
            .isActive = true

        birthdateTextField
            .centerYAnchor
            .constraint(equalTo: birthdateView.centerYAnchor)
            .isActive = true
        birthdateTextField
            .leadingAnchor
            .constraint(equalTo: birthdateLabel.trailingAnchor, constant: 20)
            .isActive = true
        anchor = birthdateTextField
            .trailingAnchor
            .constraint(lessThanOrEqualTo: birthdateView.trailingAnchor, constant: -20)
        anchor.priority = UILayoutPriority(750)
        anchor.isActive = true

        streetCodeLabel
            .topAnchor
            .constraint(equalTo: streetCodeView.topAnchor, constant: 20)
            .isActive = true
        streetCodeLabel
            .leadingAnchor
            .constraint(equalTo: streetCodeView.leadingAnchor, constant: 20)
            .isActive = true
        streetCodeLabel
            .bottomAnchor
            .constraint(equalTo: streetCodeView.bottomAnchor, constant: -20)
            .isActive = true

        streetCodeTextField
            .centerYAnchor
            .constraint(equalTo: streetCodeView.centerYAnchor)
            .isActive = true
        streetCodeTextField
            .leadingAnchor
            .constraint(equalTo: streetCodeLabel.trailingAnchor, constant: 20)
            .isActive = true
        anchor = streetCodeTextField
            .trailingAnchor
            .constraint(lessThanOrEqualTo: streetCodeView.trailingAnchor, constant: -20)
        anchor.priority = UILayoutPriority(750)
        anchor.isActive = true
        
        streetLabel
            .topAnchor
            .constraint(equalTo: streetView.topAnchor, constant: 20)
            .isActive = true
        streetLabel
            .leadingAnchor
            .constraint(equalTo: streetView.leadingAnchor, constant: 20)
            .isActive = true
        streetLabel
            .bottomAnchor
            .constraint(equalTo: streetView.bottomAnchor, constant: -20)
            .isActive = true

        streetTextField
            .centerYAnchor
            .constraint(equalTo: streetView.centerYAnchor)
            .isActive = true
        streetTextField
            .leadingAnchor
            .constraint(equalTo: streetLabel.trailingAnchor, constant: 20)
            .isActive = true
        anchor = streetTextField
            .trailingAnchor
            .constraint(lessThanOrEqualTo: streetView.trailingAnchor, constant: -20)
        anchor.priority = UILayoutPriority(750)
        anchor.isActive = true

        cityLabel
            .topAnchor
            .constraint(equalTo: cityView.topAnchor, constant: 20)
            .isActive = true
        cityLabel
            .leadingAnchor
            .constraint(equalTo: cityView.leadingAnchor, constant: 20)
            .isActive = true
        cityLabel
            .bottomAnchor
            .constraint(equalTo: cityView.bottomAnchor, constant: -20)
            .isActive = true

        cityTextField
            .centerYAnchor
            .constraint(equalTo: cityView.centerYAnchor)
            .isActive = true
        cityTextField
            .leadingAnchor
            .constraint(equalTo: cityLabel.trailingAnchor, constant: 20)
            .isActive = true
        anchor = cityTextField
            .trailingAnchor
            .constraint(lessThanOrEqualTo: cityView.trailingAnchor, constant: -20)
        anchor.priority = UILayoutPriority(750)
        anchor.isActive = true
        
        postalCodeLabel
            .topAnchor
            .constraint(equalTo: postalCodeView.topAnchor, constant: 20)
            .isActive = true
        postalCodeLabel
            .leadingAnchor
            .constraint(equalTo: postalCodeView.leadingAnchor, constant: 20)
            .isActive = true
        postalCodeLabel
            .bottomAnchor
            .constraint(equalTo: postalCodeView.bottomAnchor, constant: -20)
            .isActive = true

        postalCodeTextField
            .centerYAnchor
            .constraint(equalTo: postalCodeView.centerYAnchor)
            .isActive = true
        postalCodeTextField
            .leadingAnchor
            .constraint(equalTo: postalCodeLabel.trailingAnchor, constant: 20)
            .isActive = true
        anchor = postalCodeTextField
            .trailingAnchor
            .constraint(lessThanOrEqualTo: postalCodeView.trailingAnchor, constant: -20)
        anchor.priority = UILayoutPriority(750)
        anchor.isActive = true

        countryLabel
            .topAnchor
            .constraint(equalTo: countryView.topAnchor, constant: 20)
            .isActive = true
        countryLabel
            .leadingAnchor
            .constraint(equalTo: countryView.leadingAnchor, constant: 20)
            .isActive = true
        countryLabel
            .bottomAnchor
            .constraint(equalTo: countryView.bottomAnchor, constant: -20)
            .isActive = true

        countryTextField
            .centerYAnchor
            .constraint(equalTo: countryView.centerYAnchor)
            .isActive = true
        countryTextField
            .leadingAnchor
            .constraint(equalTo: countryLabel.trailingAnchor, constant: 20)
            .isActive = true
        anchor = countryTextField
            .trailingAnchor
            .constraint(lessThanOrEqualTo: countryView.trailingAnchor, constant: -20)
        anchor.priority = UILayoutPriority(750)
        anchor.isActive = true
        
        stackView.addArrangedSubview(firstNameView)
        stackView.addArrangedSubview(lastNameView)
        stackView.addArrangedSubview(birthdateView)
        stackView.addArrangedSubview(streetCodeView)
        stackView.addArrangedSubview(streetView)
        stackView.addArrangedSubview(cityView)
        stackView.addArrangedSubview(postalCodeView)
        stackView.addArrangedSubview(countryView)


        stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
    }
}

extension UserView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
