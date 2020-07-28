//
//  OrderViewController.swift
//  MyApp
//
//  Created by Satsishur on 24.05.2020.
//  Copyright © 2020 Consumeda. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
    //MARK: Views
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        return label
    }()
    
    let productAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        return label
    }()
    
    let orderQtyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter Order amount"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        return label
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Comments"
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        return label
    }()
    
    let orderQtyTF: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        return textField
    }()
    
    let commentsTextView: UITextView = {
         let textView = UITextView()
         textView.translatesAutoresizingMaskIntoConstraints = false
         textView.textAlignment = .left
         textView.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)
         textView.isEditable = true
         return textView
     }()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send", for: .normal)
        button.backgroundColor = UIColor(red: 52/255, green: 59/255, blue: 70/255, alpha: 1)
        button.layer.cornerRadius = 6
        return button
    }()
    //MARK: Vars
    var productName = String()
    var productAmount = String()
    var userOrder: String?
    var userCompany: String?
    var userName: String?
    var userEmail: String?
    var userComments: String?
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setLabelsText()
        setContactInfoFromUD()
        hideMenu()
        orderQtyTF.delegate = self
        commentsTextView.delegate = self
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(animateButton(sender:)), for: .touchUpInside)
        orderQtyTF.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
    }
    
    @objc func sendButtonTapped() {
        if orderQtyTF.text?.isEmpty == true {
            Alerts.showOrderAlert(viewController: self, titleMessage: "Empty fields!", message: "Please, fill in the amount field")
        } else {
            let message = makeMessage(productName: productName, orderQty: userOrder, company: userCompany, contact: userName, email: userEmail, comments: userComments)
            EmailManager.sendMailgun(with: message, subject: "Order") { (deliv) in
                DispatchQueue.main.async {
                    if deliv == true {
                        Alerts.showOrderAlert(viewController: self, titleMessage: "Success!", message: "Message delivered")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.navigationController?.popViewController(animated: true)
                        }
                    } else {
                        Alerts.showOrderAlert(viewController: self, titleMessage: "Erorr", message: "Something went wrong")
                    }
                }
            }
        }
    }
    
    func makeMessage(productName: String, orderQty: String?, company: String?, contact: String?, email: String?, comments: String?) -> String {
        let message = "\(contact ?? "erorr") from \(company ?? "erorr") wish to order \(orderQty ?? "erorr") of \(productName)\nEmail: \(email ?? "erorr") \nComments: \(comments ?? "erorr")"
        return message
    }
    
    func setLabelsText() {
        productNameLabel.text = productName
        productAmountLabel.text = "On Stock: \(productAmount)"
    }
    
    func setContactInfoFromUD() {
        userEmail = UserDefaults.standard.value(forKey: "Email") as? String
        userName = UserDefaults.standard.value(forKey: "Name") as? String
        userCompany = UserDefaults.standard.value(forKey: "Company") as? String
    }
}
//MARK: Swipe
extension OrderViewController: UIGestureRecognizerDelegate {
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
//MARK: Order TextField
extension OrderViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789.").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
      }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldChanged(_ textField: UITextField) {
        userOrder = textField.text
    }
}
//MARK: TextView
extension OrderViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        userComments = commentsTextView.text
    }
}
//MARK: Layout
extension OrderViewController {
    func setupLayout() {
        view.addSubview(productNameLabel)
        productNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        productNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        productNameLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        view.addSubview(orderQtyLabel)
        orderQtyLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 30).isActive = true
        orderQtyLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        orderQtyLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        view.addSubview(productAmountLabel)
        productAmountLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor,constant: 30).isActive = true
        productAmountLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        productAmountLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        view.addSubview(orderQtyTF)
        orderQtyTF.topAnchor.constraint(equalTo: orderQtyLabel.bottomAnchor, constant: 10).isActive = true
        orderQtyTF.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        orderQtyTF.widthAnchor.constraint(equalToConstant: 60).isActive = true
        orderQtyTF.heightAnchor.constraint(equalToConstant: 30).isActive = true
        orderQtyTF.borderStyle = .roundedRect
        view.addSubview(commentLabel)
        commentLabel.topAnchor.constraint(equalTo: orderQtyTF.bottomAnchor, constant: 30).isActive = true
        commentLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        commentLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        view.addSubview(commentsTextView)
        commentsTextView.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 10).isActive = true
        commentsTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        commentsTextView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        commentsTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        commentsTextView.layer.borderWidth = 1
        commentsTextView.layer.cornerRadius = 6
        commentsTextView.layer.borderColor = UIColor.systemGray4.cgColor
        view.addSubview(button)
        button.topAnchor.constraint(equalTo: commentsTextView.bottomAnchor, constant: 20).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
}
//MARK: AnimateButton
extension OrderViewController {
    @objc func animateButton(sender: UIButton) {
        ButtonAnimation.animate(sender)
    }
}

