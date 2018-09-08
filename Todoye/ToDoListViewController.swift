//
//  ViewController.swift
//  Todoye
//
//  Created by Georgi Malkhasyan on 9/7/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController{

    var itemsArray = ["Georgi","Iskuhi"]
    let userdefault = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let name = userdefault.array(forKey: "ToDoListArray") as? [String]{
            itemsArray  = name
        }
       
    }
    @IBAction func addButtonPresed(_ sender: UIBarButtonItem) {
        var myTextFild = UITextField()
        let alert = UIAlertController(title: "Enter new Todoye Item", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.itemsArray.append(myTextFild.text!)
            
            self.userdefault.set(self.itemsArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextFild) in
            myTextFild = alertTextFild
            alertTextFild.placeholder = "Enter items"
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        cell.textLabel?.text = itemsArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
       }else {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

