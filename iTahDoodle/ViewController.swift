//
//  ViewController.swift
//  iTahDoodle
//
//  Created by beibei cai on 2019-05-02.
//  Copyright © 2019 Jerrick Cai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var itemTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    let todoList = TodoList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        itemTextField.clearButtonMode = .whileEditing
        tableView.register(UITableViewCell.self,  forCellReuseIdentifier: "Cell")
        tableView.dataSource = todoList
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton){
        guard let todo = itemTextField.text, itemTextField.text != "" else{
            return
        }
        todoList.add(todo)
        tableView.reloadData()
        itemTextField.text = ""
    }


}

