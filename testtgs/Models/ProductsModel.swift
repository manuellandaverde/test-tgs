//
//  ProductsModel.swift
//  testtgs
//
//  Created by Manuel Landaverde on 7/7/21.
//

import Foundation

struct ProductsModel: Decodable {
    
    let name: String?
    let price: String?
    let description: String?
    let category: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "nombre"
        case price = "precio"
        case description = "descripcion"
        case category = "categoria"
    }
    
    // MARK: - Initializers
    
    init(name: String?,
         price: String?,
         description: String?,
         category: String?) {
        self.name = name
        self.price = price
        self.description = description
        self.category = category
    }
    
}
