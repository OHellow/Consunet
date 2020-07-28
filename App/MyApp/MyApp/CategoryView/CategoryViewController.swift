//
//  MainViewController.swift
//  MyApp
//
//  Created by Satsishur on 06.04.2020.
//  Copyright © 2020 Consumeda. All rights reserved.
//

import Foundation
import UIKit

class CategoryViewController: UIViewController {
//MARK: Views
    let tableView = UITableView()
    
    let bottomLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Didn't find what you need?"
        return label
    }()
    
    let bottomLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Let us know"
        label.textColor = UIColor(red: 117/255, green: 206/255, blue: 179/255, alpha: 1)
        return label
    }()
    
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
//MARK: Vars
    var codes: Any = ()
    var descriptions = Array<String>()
    var productAmounts = Int()
    var sectionData: [Section] = []
    
//MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBottomLabels()
        self.setLoadingScreen()
        navigationController?.navigationBar.tintColor = UIColor(red: 117/255, green: 206/255, blue: 179/255, alpha: 1)        
        DatabaseManager.getDatabase(from: Constants.databaseId) { database in
            guard let database = database else {
                return
            }
            self.sectionData = database
            self.sectionData.sort(by: {a, b in
                return a.category > b.category
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.removeLoadingScreen()
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.85).isActive = true
        tableView.tableFooterView = UIView()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
    }
}
//MARK: TableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionData[section].collapsed ? 0 : sectionData[section].items.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        header.titleLabel.text = sectionData[section].category
        header.arrowLabel.text = ">"
        header.setCollapsed(sectionData[section].collapsed)
        header.section = section
        header.delegate = self
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //if sectionData[indexPath.section].collapsed == true { return UITableViewCell() }
        let productCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ProductCell ?? ProductCell(style: .default, reuseIdentifier: "cell")
        let cell = sectionData[indexPath.section].items[indexPath.row]
        if let str = cell.code as? Int  {
            let i = String(str)
            productCell.codeLabel.text = i
        } else {
            productCell.codeLabel.text = cell.code as? String
        }
        productCell.descriptionLabel.text = cell.description
        productCell.amountLabel.text = String(cell.availableAmount)
        productCell.accessoryType = .disclosureIndicator
        return productCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //if sectionData[indexPath.section].collapsed == true { return 0 }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
//MARK: TableViewDelegeta
extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = sectionData[indexPath.section].items[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "OrderVC") as! OrderViewController
        vc.title = "Order"
        if let str = cell.code as? Int  {
          let i = String(str)
            vc.productName = i
            } else {
            vc.productName = cell.code as? String ?? "No info"
        }
        vc.productAmount = String(cell.availableAmount)
        navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK: Setup BottomLabels
extension CategoryViewController {
    func setupBottomLabels() {
        view.addSubview(bottomLabel1)
        bottomLabel1.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        bottomLabel1.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
        
        view.addSubview(bottomLabel2)
        bottomLabel2.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        bottomLabel2.topAnchor.constraint(equalTo: bottomLabel1.bottomAnchor, constant: 5).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        bottomLabel2.isUserInteractionEnabled = true
        bottomLabel2.addGestureRecognizer(tap)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        let vc = storyboard?.instantiateViewController(identifier: "EnquiryVC") as! EnquiryViewController
        vc.title = "Enquiry"
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: Setup Activity Indicator
extension CategoryViewController {
    func setLoadingScreen() {
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x: CGFloat = (view.frame.width / 2) - (width / 2)
        let y: CGFloat = view.frame.height * 0.05
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        // Sets loading text
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Loading..."
        loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
        // Sets spinner
        spinner.style = UIActivityIndicatorView.Style.medium
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.startAnimating()
        // Adds text and spinner to the view
        loadingView.addSubview(spinner)
        loadingView.addSubview(loadingLabel)

        tableView.addSubview(loadingView)
    }

    func removeLoadingScreen() {
        spinner.stopAnimating()
        spinner.hidesWhenStopped = true
        loadingLabel.isHidden = true
    }
}

//MARK: HeaderDelegate
extension CategoryViewController: CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sectionData[section].collapsed
        // Toggle collapse
        sectionData[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        // Reload the whole section
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
}



