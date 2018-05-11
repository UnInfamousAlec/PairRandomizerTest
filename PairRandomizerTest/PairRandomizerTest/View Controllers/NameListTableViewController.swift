//
//  NameListTableViewController.swift
//  PairRandomizerTest
//
//  Created by Alec Osborne on 5/11/18.
//  Copyright © 2018 UnInfamous Games. All rights reserved.
//

import UIKit

class NameListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    
    
    // MARK: - Actions
    @IBAction func nameAddButtonPressed(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Add Name", message: "Please add a first and last name", preferredStyle: .alert)
        
        alertController.addTextField { (firstNameTextField) in
            firstNameTextField.placeholder = "Enter first name..."
            firstNameTextField.keyboardType = .namePhonePad
        }
        
        alertController.addTextField { (lastNameTextField) in
            lastNameTextField.placeholder = "Enter last name..."
            lastNameTextField.keyboardType = .namePhonePad
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            
            guard let firstNameEntered = alertController.textFields?.first?.text, firstNameEntered != "", let lastNameEntered = alertController.textFields?.last?.text, lastNameEntered != "" else { return }
            RandomizerModelController.shared.createPerson(withFirstName: firstNameEntered, lastName: lastNameEntered)
            self.tableView.reloadData()
        }
        alertController.addAction(addAction)
        
        present(alertController, animated: true)
    }
    
    @IBAction func randomizerButtonPressed(_ sender: UIButton) {
        
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Datasource Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Change to make pairs
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RandomizerModelController.shared.names.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let name = RandomizerModelController.shared.names[indexPath.row]
        cell.textLabel?.text = "\(name.firstName) \(name.lastName)"
        return cell
    }
    
    
    // MARK: - Delegate Methods
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let name = RandomizerModelController.shared.names[indexPath.row]
            RandomizerModelController.shared.deletePerson(from: name)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
}
