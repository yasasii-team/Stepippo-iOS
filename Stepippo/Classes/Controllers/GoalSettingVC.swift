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
    
    var addTaskCount = 0
    
    // MARK: - IBOutlet properties
    @IBOutlet private weak var addTaskTextField: UITextField!
    @IBOutlet private weak var addTaskTableView: UITableView!
    
    // MARK: - IBAction methods
    @IBAction func stopButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func stockButton(_ sender: Any) {
    }
    
    @IBAction func addButton(_ sender: Any) {
        if addTaskCount < 4 {
            addTaskCount = addTaskCount + 1
        } else {
            // アラート処理
        }
        
    }
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addTaskTextField.delegate = self
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
        return addTaskCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? AddTaskCell {
            return cell
        }
        return UITableViewCell()
    }
}

