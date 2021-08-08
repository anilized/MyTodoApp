//
//  AddTodoViewController.swift
//  MyTodoApp
//
//  Created by Anil Can on 8.08.2021.
//

import UIKit

class AddTodoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var field: UITextField!
    @IBOutlet var fieldDesc: UITextField!
    
    var update: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        fieldDesc.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveTask()
        
        return true
    }
    
    @objc func saveTask(){
        guard let text = field.text, !text.isEmpty else { return }
        
        guard let textDesc = fieldDesc.text, !textDesc.isEmpty else {return }
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {return }
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        
        UserDefaults().set(text, forKey: "task_\(newCount)")
        
        UserDefaults().setValue(textDesc, forKey: "task_desc_\(newCount)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
    }

}
