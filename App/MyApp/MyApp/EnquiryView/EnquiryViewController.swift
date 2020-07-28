//
//  EnquiryViewController.swift
//  MyApp
//
//  Created by Satsishur on 15.07.2020.
//  Copyright © 2020 Consumeda. All rights reserved.
//

import UIKit

class EnquiryViewController: UIViewController {
//MARK: Views
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please, write down your request\n We will response as soon as possible"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        return label
    }()
    
    let commentsTextView: UITextView = {
         let textView = UITextView()
         textView.translatesAutoresizingMaskIntoConstraints = false
         textView.textAlignment = .left
         textView.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)
         textView.isEditable = true
         return textView
     }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send", for: .normal)
        button.backgroundColor = UIColor(red: 52/255, green: 59/255, blue: 70/255, alpha: 1)
        button.layer.cornerRadius = 6
        return button
    }()
    
    @objc func animateButton(sender: UIButton) {
        ButtonAnimation.animate(sender)
    }
    //MARK: Vars
    var userComments = String()
    var userCompany: String?
    var userName: String?
    var userEmail: String?
    
    @objc func sendButtonTapped() {
        let message = makeMessage(company: userCompany, contact: userName, email: userEmail, comments: userComments)
        EmailManager.sendMailgun(with: message, subject: "Request") { (deliv) in
            DispatchQueue.main.async {
                if deliv == true {
                    Alerts.showOrderAlert(viewController: self, titleMessage: "Success!", message: "Message delivered")
                } else {
                    Alerts.showOrderAlert(viewController: self, titleMessage: "Erorr", message: "Something went wrong")
                }
            }
        }
    }
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setContactInfoFromUD()
        hideMenu()
        commentsTextView.delegate = self
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(animateButton(sender:)), for: .touchUpInside)
    }
    
    func setContactInfoFromUD() {
        userEmail = UserDefaults.standard.value(forKey: "Email") as? String
        userName = UserDefaults.standard.value(forKey: "Name") as? String
        userCompany = UserDefaults.standard.value(forKey: "Company") as? String
    }
    
    func makeMessage(company: String?, contact: String?, email: String?, comments: String?) -> String {
        let message = "\(contact ?? "erorr") from \(company ?? "erorr") \nEmail: \(email ?? "erorr") \nRequest: \(comments ?? "erorr")"
        return message
    }
}
//MARK: Gesture
extension EnquiryViewController: UIGestureRecognizerDelegate {
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
         self.view.addGestureRecognizer(swipeDown)
    }
}

extension EnquiryViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        userComments = commentsTextView.text
    } 
}
//MARK: Setup Layout
extension EnquiryViewController {
    func setupLayout() {
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24).isActive = true
        
        view.addSubview(commentsTextView)
        commentsTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        commentsTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        commentsTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        commentsTextView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        commentsTextView.layer.borderWidth = 1
        commentsTextView.layer.cornerRadius = 6
        commentsTextView.layer.borderColor = UIColor.systemGray4.cgColor
        
        view.addSubview(sendButton)
        sendButton.topAnchor.constraint(equalTo: commentsTextView.bottomAnchor, constant: 50).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
}

