//
//  HomePage.swift
//  TestModuloTech
//
//  Created by Nicolas DENNU on 28/01/2020.
//  Copyright © 2020 ndennu. All rights reserved.
//

import UIKit
import DropDown

class HomePage: UIViewController {
    
    private let cellId = "EquipmentCell"
    
    private var subscriberId: Int?
    
    private var homeViewModel = HomeViewModel()
    private var animatedCell: UICollectionViewCell?
    
    lazy var stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.distribution = .fill
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    lazy var equipmentCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor.white
        collectionView.register(EquipmentCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var filterDropDown: DropDown = {
        let dropDown = DropDown()
        dropDown.dismissMode = .onTap
        dropDown.anchorView = self.navigationItem.rightBarButtonItem!
        dropDown.bottomOffset = CGPoint(x: 0, y:(self.navigationController?.navigationBar.bounds.height)!)
        dropDown.dataSource = ProductType.allCases.map {
            $0.rawValue
        }
        dropDown.selectionAction = { (index: Int, item: String) in
            self.homeViewModel.filter(on: item)
            self.filterView.isHidden = false
            self.filterView.categoryLabel.text = item
        }
        dropDown.hide()
        return dropDown
    }()
    
    lazy var filterView: FilterView = {
        let filterView = FilterView()
        filterView.isHidden = true
        filterView.translatesAutoresizingMaskIntoConstraints = false
        return filterView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        homeViewModel.synchronize()
        equipmentCollectionView.reloadData()
    }
    
    deinit {
        homeViewModel.unsubscribe(subscriberId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        self.navigationItem.title = "Accueil"
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "account"), style: .plain, target: self, action: #selector(showUserView))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "controls"), style: .plain, target: self, action: #selector(onClickFilterButton))
        subscriberId = homeViewModel.subscribe(self)
        setView()
        equipmentCollectionView.delegate = self
        equipmentCollectionView.dataSource = self
    }
    
    @objc func showUserView() {
        self.navigationController?.pushViewController(UserView(), animated: true)
    }
    
    @objc func removeFilter(sender: UIButton) {
        self.homeViewModel.removefilter()
    }
    
    private func setView() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.addArrangedSubview(filterView)
        stackView.addArrangedSubview(equipmentCollectionView)
        view.addSubview(filterDropDown)
        
        stackView
            .topAnchor
            .constraint(equalTo: view.topAnchor)
            .isActive = true
        stackView
            .leadingAnchor
            .constraint(equalTo: view.leadingAnchor)
            .isActive = true
        stackView
            .trailingAnchor
            .constraint(equalTo: view.trailingAnchor)
            .isActive = true
        stackView
            .bottomAnchor
            .constraint(equalTo: view.bottomAnchor)
            .isActive = true
    }
    
    @objc func onClickFilterButton() {
        if filterDropDown.isHidden {
            filterDropDown.show()
            return
        }
        filterDropDown.hide()
    }
}

extension HomePage: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.filterEquipment.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EquipmentCell
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
        cell.layer.shadowOpacity = 0.5
        
        let current = homeViewModel.filterEquipment[indexPath.row]
        
        switch current {
        case let light as Light:
            cell.imageView.image = ImageUtils.getImage(fromDiviceType: .Light, withMode: light.mode)
        case let heater as Heater:
            cell.imageView.image = ImageUtils.getImage(fromDiviceType: .Heater, withMode: heater.mode)
        case let roller as RollerShutter:
            cell.imageView.image = ImageUtils.getImage(fromDiviceType: .RollerShutter, withPosition: roller.position)
        default:
            cell.imageView.image = #imageLiteral(resourceName: "problem")
        }
        
        cell.name.text = current.deviceName
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.width / 2 - 16
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let animed = animatedCell {
            let cell = animed as! EquipmentCell
            cell.stopAnimation()
            
            let currentCell = collectionView.cellForItem(at: indexPath) as! EquipmentCell
            if currentCell == cell {
                homeViewModel.removeEquipment(at: indexPath.row)
                collectionView.reloadData()
            }
            
            return
        }
        
        let equipment = homeViewModel.filterEquipment[indexPath.row]
        
        if let light = equipment as? Light {
            let viewModel = LightViewModel(from: light)
            let viewcontroller = LightDetailView(with: viewModel)
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
        if let heater = equipment as? Heater {
            let viewModel = HeaterViewModel(from: heater)
            let viewcontroller = HeaterDetailView(with: viewModel)
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
        if let roller = equipment as? RollerShutter {
            let viewModel = RollerShutterViewModel(from: roller)
            let viewcontroller = RollerShutterDetailView(with: viewModel)
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
}

extension HomePage: EquipmentCellDelegate {
    func didFinishAnimated(cell: UICollectionViewCell) {
        animatedCell = nil
    }
    
    func isAnimated(cell: UICollectionViewCell) {
        animatedCell = cell
    }
}

extension HomePage: MyObserver {
    func valueChange() {
        self.equipmentCollectionView.reloadData()
        guard homeViewModel.filterOn != nil else {
            self.filterView.isHidden = true
            return
        }
    }
}
