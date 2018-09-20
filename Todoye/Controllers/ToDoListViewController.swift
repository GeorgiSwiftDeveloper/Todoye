//
//  ViewController.swift
//  Todoye
//
//  Created by Georgi Malkhasyan on 9/7/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController{
    
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var itemsArray = [Item]()
    
    var selectedCategory: Category? {
        didSet {
            loadItem()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    
        
        

    }
    @IBAction func addButtonPresed(_ sender: UIBarButtonItem) {
        var myTextFild = UITextField()
        let alert = UIAlertController(title: "Enter new Todoye Item", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            let newMyItem = Item(context:self.context!)
            newMyItem.title = myTextFild.text!
            newMyItem.done = false
            newMyItem.parentCategory = self.selectedCategory
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
//        
//        context?.delete(itemsArray[indexPath.row])
//        itemsArray.remove(at: indexPath.row)
        itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done
        self.saveItem()
       
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    func saveItem() {
        do{
            try context?.save()
        }catch{
            print("eror saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItem(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", (selectedCategory!.name)!)
        if let additionaPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionaPredicate])
        }else{
            request.predicate = categoryPredicate
        }
        
        
        
        do{
            itemsArray = (try context?.fetch(request))!
        }catch{
            print("eror \(error)")
        }
    }

}

//MARK: - Search bar methods
extension ToDoListViewController: UISearchBarDelegate {
   
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAIN %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItem(with: request, predicate: predicate)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItem()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
