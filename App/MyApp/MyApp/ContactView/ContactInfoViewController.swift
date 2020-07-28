//
//  ContactInfoViewController.swift
//  MyApp
//
//  Created by Satsishur on 07.07.2020.
//  Copyright © 2020 Consumeda. All rights reserved.
//

import UIKit

class ContactInfoViewController: UIViewController {
    //MARK: Views
    let userEmailTF: UITextField = {
        let emailTF = UITextField()
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        emailTF.textContentType = .emailAddress
        emailTF.keyboardType = .emailAddress
        emailTF.borderStyle = .roundedRect
        emailTF.autocorrectionType = .no
        return emailTF
    }()
    
    let userNameTF: UITextField = {
        let nameTF = UITextField()
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        nameTF.borderStyle = .roundedRect
        nameTF.autocorrectionType = .no
        return nameTF
    }()
    
    let userCompanyTF: UITextField = {
        let companyTF = UITextField()
        companyTF.translatesAutoresizingMaskIntoConstraints = false
        companyTF.borderStyle = .roundedRect
        companyTF.autocorrectionType = .no
        return companyTF
    }()
    
    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        textView.text = "Please leave your contact information"
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let bottomTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        textView.text = "You can change your data in Settings later"
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Get started!", for: .normal)
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = 6
        button.isEnabled = false
        return button
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)
        return label
    }()
    
    let companyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Company"
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)
        return label
    }()
    
    let linkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        let font = UIFont.systemFont(ofSize: 17)
        let attributes = [NSAttributedString.Key.font: font]
        let attributedString = NSMutableAttributedString(string: "We respect Yours personal data's privacy and invite You to learn personal data privacy policy applicable in UAB Consumeda", attributes: attributes)
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 117/255, green: 206/255, blue: 179/255, alpha: 1), range: NSRange(location: 59, length: 5))
        label.attributedText = attributedString
        label.numberOfLines = 0
        return label
    }()
    
    @objc func handleToCategory() {
        guard let email = userEmailTF.text else {
            return
        }
        guard let name = userNameTF.text else {
            return
        }
        guard let company = userCompanyTF.text else {
            return
        }
        UserDefaults.standard.setValue(email, forKey: "Email")
        UserDefaults.standard.setValue(name, forKey: "Name")
        UserDefaults.standard.setValue(company, forKey: "Company")
        UserDefaults.standard.set(true, forKey: "SignIn")
        performSegue(withIdentifier: "goToNC", sender: nil)
    }
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        hideMenu()
        self.overrideUserInterfaceStyle = .light
        userEmailTF.delegate = self
        userNameTF.delegate = self
        userCompanyTF.delegate = self
        userEmailTF.tag = 0
        userNameTF.tag = 1
        userCompanyTF.tag = 2
        button.addTarget(self, action: #selector(handleToCategory), for: .touchUpInside)
        userEmailTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userNameTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        userCompanyTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        linkLabel.isUserInteractionEnabled = true
        linkLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:))))
    }
    
    @objc func handleTapOnLabel(_ recognizer: UITapGestureRecognizer) {
        if recognizer.didTapAttributedTextInLabel(textview: linkLabel, inRange: NSRange(location: 59, length: 5)) {
            let vc = storyboard?.instantiateViewController(identifier: "policyVC") as! PolicyViewController
            present(vc, animated: true)
        }
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}
//MARK: TextfieldDelegate
extension ContactInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        check()
    }
    
    func check() {
        if userEmailTF.text?.isEmpty == false && userNameTF.text?.isEmpty == false && userCompanyTF.text?.isEmpty == false {
            button.isEnabled = true
            button.backgroundColor = UIColor(red: 52/255, green: 59/255, blue: 70/255, alpha: 1)
        } else {
            button.isHidden = false
            button.backgroundColor = .systemGray2
        }
    }
}
//MARK: SwipeDelegeta
extension ContactInfoViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func hideKeyboardOnSwipeDown() {
        view.endEditing(true)
    }
    
    func hideMenu() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.hideKeyboardOnSwipeDown))
        swipeDown.delegate = self
        swipeDown.direction =  UISwipeGestureRecognizer.Direction.down
        swipeDown.cancelsTouchesInView = false
        self.view.addGestureRecognizer(swipeDown)
    }
}
//MARK: LayoutSetup
extension ContactInfoViewController {
    func setupLayout() {
        view.addSubview(titleTextView)
        titleTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        titleTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24).isActive = true
        titleTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24).isActive = true
        titleTextView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
        
        let mainStackView = UIStackView()
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .equalCentering
        mainStackView.spacing = 10
        
        let emailStackView = UIStackView()
        emailStackView.translatesAutoresizingMaskIntoConstraints = false
        emailStackView.axis = .vertical
        emailStackView.alignment = .fill
        emailStackView.distribution = .equalCentering
        emailStackView.spacing = 5
        
        let userStackView = UIStackView()
        userStackView.translatesAutoresizingMaskIntoConstraints = false
        userStackView.axis = .vertical
        userStackView.alignment = .fill
        userStackView.distribution = .equalCentering
        userStackView.spacing = 5
        
        let companyStackView = UIStackView()
        companyStackView.translatesAutoresizingMaskIntoConstraints = false
        companyStackView.axis = .vertical
        companyStackView.alignment = .fill
        companyStackView.distribution = .equalCentering
        companyStackView.spacing = 5
        
        view.addSubview(mainStackView)
        mainStackView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor).isActive = true
        mainStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        mainStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4).isActive = true
        mainStackView.addArrangedSubview(emailStackView)
        mainStackView.addArrangedSubview(userStackView)
        mainStackView.addArrangedSubview(companyStackView)
        
        emailStackView.addArrangedSubview(emailLabel)
        emailStackView.addArrangedSubview(userEmailTF)
        emailStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
        userStackView.addArrangedSubview(nameLabel)
        userStackView.addArrangedSubview(userNameTF)
        userStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
        companyStackView.addArrangedSubview(companyLabel)
        companyStackView.addArrangedSubview(userCompanyTF)
        companyStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1).isActive = true
        
        view.addSubview(bottomTextView)
        bottomTextView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 10).isActive = true
        bottomTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24).isActive = true
        bottomTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24).isActive = true
        bottomTextView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.05).isActive = true
        
        let linkView = UIView()
        linkView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(linkView)
        linkView.topAnchor.constraint(equalTo: bottomTextView.bottomAnchor).isActive = true
        linkView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        linkView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        linkView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15).isActive = true
        
        linkView.addSubview(linkLabel)
        linkLabel.topAnchor.constraint(equalTo: linkView.topAnchor).isActive = true
        linkLabel.leftAnchor.constraint(equalTo: linkView.leftAnchor, constant: 16).isActive = true
        linkLabel.rightAnchor.constraint(equalTo: linkView.rightAnchor, constant: -16).isActive = true
        linkLabel.bottomAnchor.constraint(equalTo: linkView.bottomAnchor).isActive = true
        
        let bottomView = UIView()
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.topAnchor.constraint(equalTo: linkView.bottomAnchor).isActive = true
        bottomView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomView.addSubview(button)
        button.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: -10).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(textview: UILabel, inRange targetRange: NSRange) -> Bool {
        guard let attrString = textview.attributedText else {
            return false
        }

        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: .zero)
        let textStorage = NSTextStorage(attributedString: attrString)

        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = textview.lineBreakMode
        textContainer.maximumNumberOfLines = textview.numberOfLines
        let labelSize = textview.bounds.size
        textContainer.size = labelSize

        let locationOfTouchInLabel = self.location(in: textview)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
