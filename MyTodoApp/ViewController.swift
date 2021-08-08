//
//  ViewController.swift
//  MyTodoApp
//
//  Created by Anil Can on 8.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var tasks = [String]()
    var descriptions = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
 */
        tableView.delegate = self
        tableView.dataSource = self
        
        //Setup
        
        if(!UserDefaults().bool(forKey: "setup")){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        //TODO : Get all current saved tasks
        updateTasks()
        
        
    }
    
    func updateTasks(){
        
        tasks.removeAll()
        descriptions.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {return}
        
        for x in 0..<count{
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
            if let desc = UserDefaults().value(forKey: "task_desc_\(x+1)") as? String {
                descriptions.append(desc)
            }
        }
        
        tableView.reloadData()
    }
    
    @IBAction func didTapAdd() {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! AddTodoViewController
        vc.title = "New Todo"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(identifier: "detail") as! TodoDetailViewController
        vc.title = "Details"
        vc.desc = descriptions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    
}

