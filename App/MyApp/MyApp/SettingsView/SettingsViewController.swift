//
//  SettingsViewController.swift
//  MyApp
//
//  Created by Satsishur on 07.07.2020.
//  Copyright © 2020 Consumeda. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    let emailTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
        textView.isEditable = true
        textView.isScrollEnabled = false
        textView.autocorrectionType = .no
        return textView
    }()
    
    let nameTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
        textView.isEditable = true
        textView.isScrollEnabled = false
        textView.autocorrectionType = .no
        return textView
    }()
    
    let companyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.light)
        textView.isEditable = true
        textView.isScrollEnabled = false
        textView.autocorrectionType = .no
        return textView
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        return label
    }()
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Company"
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        emailTextView.delegate = self
        nameTextView.delegate = self
        companyTextView.delegate = self
        emailTextView.text = UserDefaults.standard.value(forKey: "Email") as? String
        nameTextView.text = UserDefaults.standard.value(forKey: "Name") as? String
        companyTextView.text = UserDefaults.standard.value(forKey: "Company") as? String
    }
}

extension SettingsViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        switch textView {
        case emailTextView:
            UserDefaults.standard.setValue(emailTextView.text, forKey: "Email")
        case nameTextView:
            UserDefaults.standard.setValue(nameTextView.text, forKey: "Name")
        case companyTextView:
            UserDefaults.standard.setValue(companyTextView.text, forKey: "Company")
        default:
            print("error")
        }
    }
}

extension SettingsViewController {
    func setupLayout() {
        view.addSubview(emailLabel)
        emailLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        view.addSubview(emailTextView)
        emailTextView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10).isActive = true
        emailTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        emailTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        emailTextView.layer.borderWidth = 1
        emailTextView.layer.cornerRadius = 6
        emailTextView.layer.borderColor = UIColor.systemGray4.cgColor
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: emailTextView.bottomAnchor, constant: 30).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        view.addSubview(nameTextView)
        nameTextView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        nameTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        nameTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        nameTextView.layer.borderWidth = 1
        nameTextView.layer.cornerRadius = 6
        nameTextView.layer.borderColor = UIColor.systemGray4.cgColor
        
        view.addSubview(companyLabel)
        companyLabel.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: 30).isActive = true
        companyLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        companyLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        view.addSubview(companyTextView)
        companyTextView.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 10).isActive = true
        companyTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        companyTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        companyTextView.layer.borderWidth = 1
        companyTextView.layer.cornerRadius = 6
        companyTextView.layer.borderColor = UIColor.systemGray4.cgColor
    }
}
