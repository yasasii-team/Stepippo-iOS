//
//  GoalSettingVC.swift
//  Stepippo
//
//  Created by 村松龍之介 on 2019/04/17.
//  Copyright © 2019 Yasasii-kai. All rights reserved.
//

import UIKit

/// タスクの目標を設定する画面
final class GoalSettingVC: UIViewController {
    
    var taskArray: [String?] = []

    // MARK: - IBOutlet properties
    @IBOutlet private weak var addTaskTextField: UITextField!
    @IBOutlet private weak var addTaskTableView: UITableView!
    @IBOutlet private weak var tableViewHeight: NSLayoutConstraint!
    
    // MARK: - IBAction methods
    @IBAction func stopButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func stockButton(_ sender: Any) {
    }
    
    @IBAction func addButton(_ sender: Any) {
        guard addTaskTextField.text != "" else { return }
        
        if tableViewHeight.constant < 150 {
            tableViewHeight.constant += 50
        }
        if taskArray.count < 3 {
            taskArray.append(addTaskTextField.text)
            addTaskTableView.reloadData()
        }
    }
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addTaskTextField.delegate = self
        addTaskTableView.delegate = self
        addTaskTableView.dataSource = self
        addTaskTableView.register(UINib(nibName: "AddTaskCell", bundle: nil), forCellReuseIdentifier: "AddTaskCell")
    }
}

// MARK: - TextField fields
extension GoalSettingVC: UITextFieldDelegate {
    
    // MARK: - TextField properties
    
    // MARK: - TextField methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addTaskTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension GoalSettingVC: UITableViewDelegate, UITableViewDataSource {
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
}

