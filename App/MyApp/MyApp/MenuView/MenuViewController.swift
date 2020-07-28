//
//  MenuViewController.swift
//  MyApp
//
//  Created by Satsishur on 07.07.2020.
//  Copyright © 2020 Consumeda. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    let buttonShop: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Shop", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        button.backgroundColor = UIColor(red: 52/255, green: 59/255, blue: 70/255, alpha: 1)
        button.layer.cornerRadius = 6
        return button
    }()
    
    let buttonSettings: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Settings", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        button.backgroundColor = UIColor(red: 52/255, green: 59/255, blue: 70/255, alpha: 1)
        button.layer.cornerRadius = 6
        return button
    }()
    
    @objc func categoryButtonTapped() {
        let vc = storyboard?.instantiateViewController(identifier: "CategoryVC") as! CategoryViewController
        vc.title = "Categories"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func settingsButtonTapped() {
        let vc = storyboard?.instantiateViewController(identifier: "SettingsVC") as! SettingsViewController
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        buttonShop.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        buttonSettings.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        navigationItem.title = "Menu"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)]
        self.parent?.overrideUserInterfaceStyle = .light

    }
    
    func setupLayout() {
        view.addSubview(buttonShop)
        buttonShop.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonShop.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        buttonShop.heightAnchor.constraint(equalToConstant: 80).isActive = true
        buttonShop.widthAnchor.constraint(equalToConstant: 160).isActive = true
        view.addSubview(buttonSettings)
        buttonSettings.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonSettings.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60).isActive = true
        buttonSettings.heightAnchor.constraint(equalToConstant: 80).isActive = true
        buttonSettings.widthAnchor.constraint(equalToConstant: 160).isActive = true
    }
}
