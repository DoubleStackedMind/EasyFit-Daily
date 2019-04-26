//
//  User.swift
//  EasyFit Daily
//
//  Created by Ahmed amine on 4/25/19.
//  Copyright © 2019 Ahmed amine. All rights reserved.
//

import Foundation
public class User {
    var name:String
    var email:String
    var datenaissance:Date
    var password:String
    init ( name:String, email:String, datenaissance:Date, password:String){
        self.name = name
        self.email = email
        self.datenaissance = datenaissance
        self.password = password
    }
 
}
