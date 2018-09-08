//
//  ViewController.swift
//  Todoye
//
//  Created by Georgi Malkhasyan on 9/7/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController{
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("List.Plist")
    
    var itemsArray = [Item]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print(dataFilePath!)
        
    
        
        loadItem()

    }
    @IBAction func addButtonPresed(_ sender: UIBarButtonItem) {
        var myTextFild = UITextField()
        let alert = UIAlertController(title: "Enter new Todoye Item", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            let newMyItem = Item()
            newMyItem.title = myTextFild.text!
            self.itemsArray.append(newMyItem)
            

            self.saveItem()
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
    
    func saveItem() {
        let ecoder = PropertyListEncoder()
        
        do{
            let data = try? ecoder.encode(itemsArray)
            try data?.write(to: dataFilePath! )
        }catch{
            print("save items eror \(error)")
        }
    }
    
    func loadItem() {
        if let data = try? Data.init(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
            itemsArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("error")
            }
        }
        
    }

}

