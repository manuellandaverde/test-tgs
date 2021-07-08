//
//  LoginModel.swift
//  testtgs
//
//  Created by Manuel Landaverde on 7/7/21.
//

import Foundation

struct LoginModel: Decodable {
    
    var alias : String?
    var apellido : String?
    var created_at : String?
    var device_token : String?
    var email : String?
    var estado_tienda : String?
    var formulario_pedido : Bool?
    var id : Int?
    var is_active : Bool?
    var nombre : String?
    var password : String?
    var store : String?
    var store_id : Int?
    var uid : String?
    
    // MARK: - Initializers
    
    init() { }
    
}
