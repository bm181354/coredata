//
//  ViewController.swift
//  Todeay
//
//  Created by Biken Maharjan on 4/11/18.
//  Copyright © 2018 Biken Maharjan. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = ["Watch Liverpool", "Buy milk", "Meditate"]
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    //fileprivate let fileDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    var items = [Item]()
    
    // objective-interface
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toLoad()
    }
    
    
    //MARK - Add New Items and create alert
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        
        var localString = UITextField()
        
        let alert: UIAlertController = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action:UIAlertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in

            //self.itemArray.append(localString.text!)
            
            // UI application static variable and getting the persistentContainer
            
            let item = Item(context: self.context)
            item.value = localString.text!
            item.flag = false
            self.items.append(item)
            
            // encodes data and saves to the application hardware
            self.toSave()

            
        }
        
        alert.addTextField { (textField) in
            
            textField.placeholder = "ADD NEW ITEM"
            localString = textField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }

}

extension TodoListViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].value
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // check mark accessory in the cell [usually hidden]
        
        context.delete(items[indexPath.row])
        items.remove(at: indexPath.row)
        toSave()
        
        
        
//        if items[indexPath.row].flag == true {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//            items[indexPath.row].flag = !items[indexPath.row].flag
//            toSave()
//            
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//            items[indexPath.row].flag = !items[indexPath.row].flag
//            toSave()
//        }
//        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK:- encode items array into plist or json here
    func toSave(){
        
        do {
           try context.save()
        }catch{
            
            print("Error")
            
        }
        
        self.tableView.reloadData()
        
    }
    

    func toLoad(){
        // Item is a class/entity
        let request:NSFetchRequest<Item> = Item.fetchRequest()
        do {
        // returns array  of Item
        items =  try context.fetch(request)
            
        }catch {
            print("Error is \(error)")
        }
   
    }

    
    
    
}

