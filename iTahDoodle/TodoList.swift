//
//  TodoList.swift
//  iTahDoodle
//
//  Created by beibei cai on 2019-05-02.
//  Copyright © 2019 Jerrick Cai. All rights reserved.
//

import UIKit

class TodoList: NSObject {
    
    private let fileURL: URL = {
        let documentDirectoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDitectoryURL = documentDirectoryURLs.first!
        return documentDitectoryURL.appendingPathComponent("todolist.items")
    }()
    
    fileprivate var items: [String] = []
    
    override init() {
        super.init()
        loadItems()
    }
    
    func saveItems(){
        let itemsArray = items as NSArray
        
        print("Saving items to \(fileURL)")
        if !itemsArray.write(to: fileURL, atomically: true){
            print("Could not save to-do list")
        }
    }
    
    func loadItems(){
        if let itemsArray = NSArray(contentsOf: fileURL) as? [String]{
            items = itemsArray
        }
    }
    func add(_ item: String){
        items.append(item)
        saveItems()
    }
    
}

extension TodoList: UITableViewDataSource{
    // Return the number of rows for the table.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // Provide a cell object for each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let item = items[indexPath.row]
        // Configure the cell’s contents.
        cell.textLabel!.text = item
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        saveItems()
    }
}
