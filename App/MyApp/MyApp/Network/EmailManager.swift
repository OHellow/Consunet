//
//  EmailManager.swift
//  MyApp
//
//  Created by Satsishur on 26.05.2020.
//  Copyright © 2020 Consumeda. All rights reserved.
//

import Foundation
import Alamofire

class EmailManager {
    static func sendMailgun(with message: String, subject: String, completion: @escaping ((_ deliv: Bool?) -> ())) {

        let user = "api"
        let password = Constants.mailgunAPIkey

        let credentialData = "\(user):\(password)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!

        let base64Credentials = credentialData.base64EncodedString()
        
        let header = [
            "Authorization": "Basic \(base64Credentials)",
            "Content-Type" : "application/x-www-form-urlencoded"]
        
        let headers = HTTPHeaders.init(header)
        
        let parameters = [
            "from": "alehsat@gmail.com",
            "to": "consumeda3@gmail.com",
            "subject": subject,
            "text": message
        ]
        
        AF.request(Constants.mailgunDomain, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            var deliv: Bool
            if response.error != nil {
                deliv = false
            } else {
                deliv = true
            }
            completion(deliv)
        }
    }
}


//    static func sendEmail(with message: String, completion: @escaping ((_ deliv: Bool?) -> ())) {
//
//        let sendGrid = SendGrid(withAPIKey: "secret_api_key")
//        let content = SGContent(type: .plain, value: message)
//        let from = SGAddress(email: "olegsatol@gmail.com")
//        let personalization = SGPersonalization(to: [ SGAddress(email: "olegsatol@gmail.com") ])
//        let subject = "Order"
//
//        let email = SendGridEmail(personalizations: [personalization], from: from, subject: subject, content: [content])
//
//        sendGrid.send(email: email) { (response, error) in
//            var deliv: Bool
//
//                if let error = error {
//                    print("Error sending email: \(error.localizedDescription)")
//                    deliv = false
//                } else {
//                    print("delivered")
//
//                    deliv = true
//                }
//            completion(deliv)
//        }
//    }


