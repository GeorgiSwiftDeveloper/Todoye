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
//            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
     
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
      loadItems()
    }

    
    @IBAction func addBtn(_ sender: Any) {
        var newTextFiled = UITextField()
        let alertCont = UIAlertController(title: "add items", message: nil, preferredStyle: .alert)
        let acion = UIAlertAction(title: "Add", style: .default) { (action) in
//            let newItem = Item(context: self.context!)
//            newItem.title = newTextFiled.text
//            newItem.done = false
//            newItem.parentCtegory = self.selectedCategory
//            self.itemsArray.append(newItem)
//
//            self.saveItems()
          
            self.tableView.reloadData()
            
        }
        alertCont.addTextField { (textFiled) in
            newTextFiled = textFiled
        }
        alertCont.addAction(acion)
        present(alertCont, animated: true, completion: nil)
        
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell", for: indexPath)
        cell.textLabel?.text  = itemsArray[indexPath.row].title
       
        cell.accessoryType = itemsArray[indexPath.row].done ? .checkmark:.none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        itemsArray[indexPath.row].setValue("Completed", forKey: "title")
//        context?.delete(itemsArray[indexPath.row])
//        itemsArray.remove(at: [indexPath.row])
        itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func saveItems() {
        do{
            try context?.save()
        }catch{
            print("Can't save items ")
        }
        self.tableView.reloadData()
    }
    
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//        let categoryPredicate = NSPredicate(format: "parentCtegory.name MATCHES %@", (selectedCategory!.name)!)
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        }else {
//            request.predicate = categoryPredicate
//        }
//        //let request:NSFetchRequest<Item> = Item.fetchRequest()
//        do{
//            itemsArray = try (context?.fetch(request))!
//        }catch{
//            print("error")
//        }
//        self.tableView.reloadData()
//    }
    

}
extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        print(searchBar.text!)
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        loadItems(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
    }

