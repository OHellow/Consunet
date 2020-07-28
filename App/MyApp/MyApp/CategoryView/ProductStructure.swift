//
//  ProductStructure.swift
//  MyApp
//
//  Created by Satsishur on 25.05.2020.
//  Copyright © 2020 Consumeda. All rights reserved.
//

import Foundation

public struct Item {
    var code: Any
    var description: String
    var availableAmount: Int
    
    public init(code: Any, description: String, availableAmount: Int) {
        self.code = code
        self.description = description
        self.availableAmount = availableAmount
    }
}

public struct Section {
    var category: String
    var items: [Item] 
    var collapsed: Bool
    
    public init(category: String, items: [Item], collapsed: Bool = true) {
        self.category = category
        self.items = items
        self.collapsed = collapsed
    }
}
