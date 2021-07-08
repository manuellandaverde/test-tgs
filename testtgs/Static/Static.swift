//
//  Static.swift
//  testtgs
//
//  Created by Manuel Landaverde on 7/7/21.
//

import Foundation

class Static {
    
    static let shared = Static()
    
    let loginURL: String = "https://api.appstgs.com/validarcredenciales"
    let productsURL: String = "https://api.appstgs.com/getproducts"
    
    var loginData: LoginModel?
    
    private init() {
        loginData = LoginModel()
    }
    
}
