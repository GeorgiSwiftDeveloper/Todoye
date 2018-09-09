//
//  CategoryTableViewController.swift
//  Todoye
//
//  Created by Georgi Malkhasyan on 9/9/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    
    let contex = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    
    var categoryItems = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }


    @IBAction func addButtonPresed(_ sender: UIBarButtonItem) {
        var myTextFild = UITextField()
        
        let alert = UIAlertController(title: "Add new table name", message: nil, preferredStyle: .alert)
        let actionone = UIAlertAction(title: "OK", style: .default) { (action) in
            let newItem = Category(context: self.contex!)
            newItem.name = myTextFild.text!
            self.categoryItems.append(newItem)
            self.saveCategory()
            self.tableView.reloadData()
        }
        alert.addTextField { (textFild) in
            textFild.placeholder = "Enter new name"
            myTextFild = textFild
        }
        alert.addAction(actionone)
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryItems[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ToDoListViewController
        
        if  let indexPath = tableView.indexPathForSelectedRow {
            destination.selectedCategory = categoryItems[indexPath.row]
        }
    }
    
    
    func saveCategory() {
        do{
            try contex?.save()
        }catch{
            print("Error  save items \(error)")
        }
    }
    
    func loadCategory() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categoryItems = try (contex?.fetch(request))!
        }catch{
            print("Error load items \(error)")
        }
        tableView.reloadData()
    }
}
