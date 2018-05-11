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
        names = loadFromDocuments()
    }
    
    
    // MARK: - CRUD
    // CREATE
    func createPerson(withFirstName firstName: String, lastName: String) {
        let name = Person(firstName: firstName, lastName: lastName)
        self.names.append(name)
        saveToDocuments()
    }
    
    
    // DELETE
    func deletePerson(from name: Person) {
        guard let indexPath = names.index(of: name) else { return }
        self.names.remove(at: indexPath)
        saveToDocuments()
    }
    
    
    // MARK: - Persistance
    func fileLocation() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask).first!
        let location = path.appendingPathComponent("names").appendingPathExtension("json")
        return location
    }
    
    func saveToDocuments() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(names)
            try data.write(to: fileLocation())
        } catch let error {
            print("Unable to save: \(error) - \(error.localizedDescription)")
        }
    }
    
    func loadFromDocuments() -> [Person] {
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileLocation())
            let names = try jsonDecoder.decode([Person].self, from: data)
            return names
        } catch let error {
            print("Unable to load: \(error) - \(error.localizedDescription)")
        }
        return []
    }
}

extension Array {
    mutating func shuffle() {
        for _ in 0..<10 {
            sort {
                (_,_) in arc4random() < arc4random()
            }
        }
    }
}
