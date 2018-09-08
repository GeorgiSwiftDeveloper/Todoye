//
//  ViewController.swift
//  Todoye
//
//  Created by Georgi Malkhasyan on 9/7/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController{

    var itemsArray = [Item]()
    let userdefault = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Georgi"
        itemsArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Ika"
        itemsArray.append(newItem2)
        
        
        let newItem3 = Item()
        newItem3.title = "Adam"
        itemsArray.append(newItem3)
        
        
        if let name = userdefault.array(forKey: "ToDoListArray") as? [Item]{
            itemsArray  = name
        }

    }
    @IBAction func addButtonPresed(_ sender: UIBarButtonItem) {
        var myTextFild = UITextField()
        let alert = UIAlertController(title: "Enter new Todoye Item", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            let newMyItem = Item()
            newMyItem.title = myTextFild.text!
            self.itemsArray.append(newMyItem)
            
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
      
        let items = itemsArray[indexPath.row]
        cell.textLabel?.text = items.title
        cell.accessoryType = items.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

