//
//  MainViewController.swift
//  MyApp
//
//  Created by Satsishur on 06.04.2020.
//  Copyright © 2020 Consumeda. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CategoryViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    
    var productInfo = Array<Product>()
    var categoryNames = Array<String>()
    
    var codes = Array<Any>()
    var descriptions = Array<String>()
    var productAmounts = Array<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        DataManager.getDatabase(from: Constants.databaseId , completion:  { database in
            var buf = Array<Product>()
            guard let database = database else {return}
            for (key, value) in database {
                self.categoryNames.append(key)
                for val in value {
                    buf.append(Product(category: key, code: val.value(forKey: "code") ?? "error", description: val.value(forKey: "description") as? String ?? "error", availableAmount: val.value(forKey: "how many left") as? Int ?? 0))
                }
            }
            self.categoryNames.sort(by: {$0 > $1})
            self.productInfo = buf
            //print(MainViewController.database ?? "nil")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}

extension CategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as UITableViewCell? else {fatalError("Error")}
        categoryCell.textLabel?.text = categoryNames[indexPath.row]
        return categoryCell
    }
}

extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var info = Array<Any>()
        var desc = Array<String>()
        var num = Array<Int>()
        
        for val in 0..<productInfo.count where productInfo[val].category == categoryNames[indexPath.row] {
            info.append(productInfo[val].code)
            desc.append(productInfo[val].description)
            num.append(productInfo[val].availableAmount)
        }
        self.codes = info
        self.descriptions = desc
        self.productAmounts = num
        performSegue(withIdentifier: "goToProducts", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? ProductsViewController
        destinationVC?.codes = self.codes
        destinationVC?.descs = self.descriptions
        destinationVC?.nums = self.productAmounts
    }
}
//        self.ref.child("1EnQVZBtq3yZuUJ6ytHrkq-xNa66cy3AdLw-g7o0ZE-U").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let value = snapshot.value as? [String: Array<NSDictionary>]  {


//                for (key, val) in value {
//                    print(key)
//                    self.arr.append(contentsOf: val)
//                }
//
//                for i in 0..<self.arr.count {
//                    print(self.arr[i])//.value(forKey: "code")!)
//                }
//                for i in 0..<self.arr.count {
//                    print(self.arr[i])
//                }
//
//
//                for (key, val) in value where key == "FlowSensors" {
//                    print(key)
//                    self.arr.append(contentsOf: val)
//                }
//                for i in 0..<self.arr.count {
//                    print(self.arr[i])
//                }

//                print(value)
//                for key in value.keys {
//                    self.strArr.append(key)
//                }
//
//                let index = 0
//
//                for (key, val) in value where key == self.strArr[index] {
//                    self.arr.append(contentsOf: val)
//                }
//                for i in 0..<self.arr.count {
//                    //print(self.arr[i])
//                    print(self.arr[i].value(forKey: "code")!)
//                }


//            }
//        })


