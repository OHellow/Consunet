//
//  Alerts.swift
//  MyApp
//
//  Created by Satsishur on 29.05.2020.
//  Copyright © 2020 Consumeda. All rights reserved.
//

import UIKit

enum Alerts {
    
    static func showOrderAlert(viewController: UIViewController, titleMessage: String, message: String) {
        let alert = UIAlertController(title: titleMessage, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alert, animated: true, completion: nil)
    }
}
