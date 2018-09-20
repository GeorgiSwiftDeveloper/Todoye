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
    var categorys = [Category]()
 let contex = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadCategrys()
    }


    @IBAction func addButtonPresed(_ sender: UIBarButtonItem) {
        var messageText = UITextField()
     let alert = UIAlertController(title: "add text", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            let newCategory = Category(context: self.contex!)
            newCategory.name = messageText.text!
            self.categorys.append(newCategory)
            self.tableView.reloadData()
            
            self.saveCategory()
        }
        alert.addTextField { (textfild) in
            messageText = textfild
            messageText.placeholder = "Add item"
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  categorys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categorys[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categorys[indexPath.row]
        }
    }
    
    func saveCategory() {
        do{
            try contex?.save()
        }catch{
            print("Error to save categorys")
        }
    }
    
    func loadCategrys() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categorys = try (contex?.fetch(request))!
        }catch{
            
        }
    }

}
