//
//  TodoDetailViewController.swift
//  MyTodoApp
//
//  Created by Anil Can on 8.08.2021.
//

import UIKit

class TodoDetailViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    var desc: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = desc
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask(){
        
        // let newCount = count - 1
        
        // UserDefaults().setValue(newCount, forKey: "count")
        // UserDefaults().setValue(nil, forKey: "tasks_\(currentPosition)")
    }
    

}
