//
//  CategoryController.swift
//  Todoye
//
//  Created by Georgi Malkhasyan on 11/24/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryController: UITableViewController {
    // let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    let realm = try! Realm()
    var categoryArray: Results<Category>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchRequest()
        loadItems()
    }

    @IBAction func barBtnnTapped(_ sender: UIBarButtonItem) {
        var categoryTxt = UITextField()
        let alert = UIAlertController(title: "Add category", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
//            let newCategory = Category(context: self.contex!t)
             let newCategory = Category()
            newCategory.name = categoryTxt.text!
//            self.categoryArray.append(newCategory)
            self.saveItems()
            self.tableView.reloadData()
            
        }
        alert.addTextField { (texfild) in
            categoryTxt = texfild
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
 


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goItemVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let index = tableView.indexPathsForSelectedRows?.first {
            destinationVC.selectedCategory = categoryArray[index.row]
        }
    }
    
//
//    func saveItems() {
//        do{
//            try context?.save()
//        }catch{
//            print("Can't save items ")
//        }
//        self.tableView.reloadData()
//    }
    
    
    func saveItems() {
        do{
            try realm.write {
                realm.add(categoryArray)
            }
        }catch{
            print("Can't save items ")
        }
        self.tableView.reloadData()
    }

    
    func loadItems() {
        categoryArray = realm.objects(Category.self)
    }
    
//    func fetchRequest() {
//        let request:NSFetchRequest<Category> = Category.fetchRequest()
//        do{
//            categoryArray = try (context?.fetch(request))!
//        }catch{
//            print("error")
//        }
//        self.tableView.reloadData()
//    }

   
}
