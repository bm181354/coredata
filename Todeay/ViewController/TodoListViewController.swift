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

    fileprivate let fileDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    var items = [Item]()
    
    // objective-interface
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        //print(fileDir)
        
        //itemArray = defaults.value(forKey: "todoItemCell")  as! [String]
//        if let items = defaults.array(forKey: "toDoArray") as? [String]{
//            itemArray = items
//        }
        toLoad()
        
    }
    
    
    //MARK - Add New Items and create alert
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        
        
        var localString = UITextField()
        
        let alert: UIAlertController = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action:UIAlertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in

            //self.itemArray.append(localString.text!)
            
            let item = Item(value: localString.text!)
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
        if items[indexPath.row].flag! == true {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            items[indexPath.row].flag = !items[indexPath.row].flag!
            toSave()
            
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            items[indexPath.row].flag = !items[indexPath.row].flag!
            toSave()
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK:- encode items array into plist or json here
    func toSave(){
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.items)
            try data.write(to:self.fileDir!)
        }catch{
            print("Error")
        }
        
        self.tableView.reloadData()
        
    }
    
    func toLoad(){
        if let data = try? Data(contentsOf:self.fileDir!){
            let decoder = PropertyListDecoder()
            do {
                items = try decoder.decode([Item].self, from: data)
                }catch{}
            }
    }
    
    
    
}

