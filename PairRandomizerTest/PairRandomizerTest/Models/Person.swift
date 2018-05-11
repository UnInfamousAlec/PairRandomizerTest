//
//  Name.swift
//  PairRandomizerTest
//
//  Created by Alec Osborne on 5/11/18.
//  Copyright © 2018 UnInfamous Games. All rights reserved.
//

import Foundation

class Person: Equatable, Codable {
    
    let firstName: String
    let lastName: String
    
    init(firstName: String, lastName: String) {
        
        self.firstName = firstName
        self.lastName = lastName
    }
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
    }
}
