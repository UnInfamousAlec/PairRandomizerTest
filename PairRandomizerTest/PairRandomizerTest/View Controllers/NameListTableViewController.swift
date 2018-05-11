//
//  NameListTableViewController.swift
//  PairRandomizerTest
//
//  Created by Alec Osborne on 5/11/18.
//  Copyright © 2018 UnInfamous Games. All rights reserved.
//

import UIKit

class NameListTableViewController: UITableViewController {
    
    // MARK: - Actions
    @IBAction func nameAddButtonPressed(_ sender: UIBarButtonItem) {
        
        addNewPerson()
    }
    
    @IBAction func randomizerButtonPressed(_ sender: UIButton) {
        
        RandomizerModelController.shared.names.shuffle()
        tableView.reloadData()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

    // MARK: - Datasource Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        if RandomizerModelController.shared.names.count % 2 == 0 {
            return RandomizerModelController.shared.names.count / 2
        } else {
            return (RandomizerModelController.shared.names.count / 2) + 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
        let section = indexPath.section
        let row = indexPath.row
        let newIndexPath = sectionsAndRows(section: section, row: row)
        if newIndexPath >= RandomizerModelController.shared.names.count {
            return cell
        }
        let name = RandomizerModelController.shared.names[newIndexPath]
        cell.textLabel?.text = "\(name.firstName) \(name.lastName)"
        return cell
    }
    
    
    // MARK: - Delegate Methods
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let name = RandomizerModelController.shared.names[indexPath.row]
            RandomizerModelController.shared.deletePerson(from: name) // Need to fix app crash when person in deleted
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Additional Methods
    func addNewPerson() {
        let alertController = UIAlertController(title: "Add Name", message: "Please add a first and last name", preferredStyle: .alert)
        
        alertController.addTextField { (firstNameTextField) in
            firstNameTextField.placeholder = "Enter first name..."
            firstNameTextField.keyboardType = .namePhonePad
        }
        
        alertController.addTextField { (lastNameTextField) in
            lastNameTextField.placeholder = "Enter last name..."
            lastNameTextField.keyboardType = .namePhonePad
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            
            guard let firstNameEntered = alertController.textFields?.first?.text, firstNameEntered != "", let lastNameEntered = alertController.textFields?.last?.text, lastNameEntered != "" else { return }
            RandomizerModelController.shared.createPerson(withFirstName: firstNameEntered, lastName: lastNameEntered)
            
            self.tableView.reloadData()
        }
        alertController.addAction(addAction)
        
        present(alertController, animated: true)
    }
    
    func sectionsAndRows(section: Int, row: Int) -> Int {
        return (section * 2) + row
    }
}
