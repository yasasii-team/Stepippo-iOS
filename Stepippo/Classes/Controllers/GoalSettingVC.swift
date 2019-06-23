//
//  GoalSettingVC.swift
//  Stepippo
//
//  Created by 村松龍之介 on 2019/04/17.
//  Copyright © 2019 Yasasii-kai. All rights reserved.
//

import UIKit
import RealmSwift
/// タスクの目標を設定する画面
final class GoalSettingVC: UIViewController, RealmObjectAccessible {
    var taskArray: [String] = []
    let realm = try! Realm()
    // MARK: - IBOutlet properties
    @IBOutlet private weak var addTaskTextField: UITextField!
    @IBOutlet private weak var addTaskTableView: UITableView!
    @IBOutlet private weak var tableViewHeight: NSLayoutConstraint!
    
    // MARK: - IBAction methods
    @IBAction func stopButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func stockButton(_ sender: Any) {
        
        if let addTaskText = addTaskTextField.text, !addTaskText.isEmpty {
            let ippo = IPPO()
            ippo.title = addTaskText
            ippo.status = .stock
            write(ippo)
        } else {
            let alert = UIAlertController(title: "アラート表示", message: "タスク名が空です", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "タスク名を入力する", style: .cancel, handler:{
                (action: UIAlertAction!) -> Void in
                print("Cancel")
            })
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
            
            
    }
    
    @IBAction func addButton(_ sender: Any) {
        guard addTaskTextField.text != "" else { return }
        
        if tableViewHeight.constant < 150 {
            tableViewHeight.constant += 50
        }
        if taskArray.count < 3 {
            guard let task = addTaskTextField.text else { return }
            taskArray.append(task)
            addTaskTableView.reloadData()
            addTaskTextField.text = ""
        } else {
            let alert = UIAlertController(title: "アラート表示", message: "IPPOは最大３つまでの登録です。", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler:{
                (action: UIAlertAction!) -> Void in
                print("Cancel")
            })
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func doneButton(_ sender: Any) {
        let ippoList = fetch(IPPO.self, predicate: NSPredicate(format: "_status = %@", argumentArray: [IPPOStatus.challenging.rawValue, IPPOStatus.performed.rawValue]))

        var sameTitle:[Int] = []
        for _ in 0..<taskArray.count {
            sameTitle.append(0)
        }
        
        var i = 0
        for task in taskArray {
            for ippo in ippoList {
                if ippo.title == task {
                    sameTitle[i] += 1
                }
            }
            i += 1
        }
        i = 0
        for title in sameTitle {
            if title == 0 {//同じタイトルじゃない場合IPPOを登録
                let ippo = IPPO()
                ippo.title = taskArray[i]
                ippo.status = .challenging
                write(ippo)
            }
            i += 1
        }
    }
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addTaskTextField.delegate = self
        addTaskTableView.delegate = self
        addTaskTableView.dataSource = self
        addTaskTableView.register(UINib(nibName: "AddTaskCell", bundle: nil), forCellReuseIdentifier: "AddTaskCell")
        
        let ippoList = fetch(IPPO.self, predicate: NSPredicate(format: "_status = %@", argumentArray: [IPPOStatus.challenging.rawValue, IPPOStatus.performed.rawValue]))
        for ippo in ippoList {
            if tableViewHeight.constant < 150 {
                tableViewHeight.constant += 50
            }
            taskArray.append(ippo.title)
        }
        addTaskTableView.reloadData()
    }
}

// MARK: - TextField fields
extension GoalSettingVC: UITextFieldDelegate {
    
    // MARK: - TextField methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addTaskTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - TableView fields

extension GoalSettingVC: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - TableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addTaskTableView.dequeueReusableCell(withIdentifier: "AddTaskCell") as! AddTaskCell
        cell.addTaskLabel.text = taskArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let ippoList = fetch(IPPO.self, predicate: NSPredicate(format: "_status = %@", argumentArray: [IPPOStatus.challenging.rawValue, IPPOStatus.performed.rawValue]))
            for ippo in ippoList {
                if ippo.title == taskArray[indexPath.row] {
                    try! realm.write {
                        realm.delete(ippo)
                    }
                }
            }
            
            taskArray.remove(at: indexPath.row)
            addTaskTableView.deleteRows(at: [indexPath], with: .fade)
            tableViewHeight.constant -= 50
        }
    }
}

