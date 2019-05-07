//
//  ViewController.swift
//  Todoye
//
//  Created by Georgi Malkhasyan on 9/7/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import  RealmSwift

class ToDoListViewController: UITableViewController{
    
    let realm = try! Realm()
    
    var itemsArray: Results<Item>?

    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func addBtn(_ sender: Any) {
        var newTextFiled = UITextField()
        let alertCont = UIAlertController(title: "add items", message: nil, preferredStyle: .alert)
        let acion = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory  {
               
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = newTextFiled.text!
                        newItem.done = false
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    
                }
            }
           

          
            self.tableView.reloadData()
            
        }
        alertCont.addTextField { (textFiled) in
            newTextFiled = textFiled
        }
        alertCont.addAction(acion)
        present(alertCont, animated: true, completion: nil)
        
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell", for: indexPath)
        if let item = itemsArray?[indexPath.row]  {
            cell.textLabel?.text  = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        }else {
            cell.textLabel?.text = "No items"
        }
        
       
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        itemsArray[indexPath.row].done = !itemsArray[indexPath.row].done
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
    
    func loadItems() {
        itemsArray = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    

}
extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        
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

