//
//  RandomizerModelController.swift
//  PairRandomizerTest
//
//  Created by Alec Osborne on 5/11/18.
//  Copyright © 2018 UnInfamous Games. All rights reserved.
//

import Foundation

class RandomizerModelController {
    
    // MARK: - Singleton
    static let shared = RandomizerModelController()
    
    
    // MARK: - Source of Truth
    var names: [Person] = []
    
    init() {
        
    }
    
    
    // MARK: - CRUD
    // CREATE
    func createPerson(with firstName: String, lastName: String) {
        let name = Person(firstName: firstName, lastName: lastName)
        self.names.append(name)
        // Add persistance
    }
    
    
    // DELETE
    func deletePerson(from name: Person) {
        guard let indexPath = names.index(of: name) else { return }
        self.names.remove(at: indexPath)
        // Add persistance
    }
    
    
    // MARK: - Methods
    func randomizer() {
        
    }
    
    
    // MARK: - Persistance
    
}
