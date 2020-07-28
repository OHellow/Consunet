//
//  DataManager.swift
//  MyApp
//
//  Created by Satsishur on 12.05.2020.
//  Copyright © 2020 Consumeda. All rights reserved.
//

import Foundation
import Firebase

class DatabaseManager {
        
    class func getDatabase(from id: String, completion: @escaping ((_ database: [Section]?) -> ())) {
        let ref: DatabaseReference
        ref = Database.database().reference()
        
        ref.child(id).observe(DataEventType.value, with: { (snapshot) in
            var database: [Section] = []
            if let value = snapshot.value as? [String: Array<NSDictionary>]  {
                var items: [Item] = []
                for (key, value) in value {
                    for val in value {
                        items.append(Item(code: val.value(forKey: "code") ?? "no info", description: val.value(forKey: "description") as? String ?? "no info", availableAmount: val.value(forKey: "amount") as? Int ?? 0))
                    }
                    database.append(Section(category: key, items: items))
                    items.removeAll()
                }
            } 
            completion(database)
        })
    }
}
