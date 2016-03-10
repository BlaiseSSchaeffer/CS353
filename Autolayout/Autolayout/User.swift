//
//  User.swift
//  Autolayout
//
//  Created by Blaise Schaeffer on 3/9/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let company: String
    let login: String
    let password: String
    
    static func login(login: String, password: String) -> User? {
        if let user = database[login] {
            if user.password == password {
                return user
            }
        }
        return nil
    }
    
    static let database: [String: User] = {
        var theDatabase = [String: User]()
        for user in [
            User(name: "Blaise Schaeffer", company: "IBM", login: "blaise2s", password: "b2s"),
            User(name: "Mackenzie Schaeffer", company: "NA", login: "mack", password: "mfs"),
            User(name: "Brent Schaeffer", company: "NA", login: "brent", password: "bns")
            ] {
                theDatabase[user.login] = user
        }
        return theDatabase
    }()
    
}