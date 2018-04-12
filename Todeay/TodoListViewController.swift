//
//  ViewController.swift
//  Todeay
//
//  Created by Biken Maharjan on 4/11/18.
//  Copyright © 2018 Biken Maharjan. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Watch Liverpool", "Buy milk", "Meditate"]

    // objective-interface
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //itemArray = defaults.value(forKey: "todoItemCell")  as! [String]
        if let items = defaults.array(forKey: "toDoArray") as? [String]{
            itemArray = items
        }
    }
    
    
    //MARK - Add New Items and create alert
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        
        var localString = UITextField()
        
        let alert: UIAlertController = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action:UIAlertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in

            self.itemArray.append(localString.text!)
            self.defaults.set(self.itemArray, forKey: "toDoArray")
            
            self.tableView.reloadData()
            
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
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(itemArray[indexPath.row])
        
        
        // check mark accessory in the cell [usually hidden]
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
}

