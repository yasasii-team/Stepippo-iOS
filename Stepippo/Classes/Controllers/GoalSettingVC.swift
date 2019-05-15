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
    
    // MARK: - IBOutlet properties
    @IBOutlet weak var addtaskTextField: UITextField!
    
    // MARK: - IBAction methods
    @IBAction func stopButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func stockButton(_ sender: Any) {
    }
    
    @IBAction func addButton(_ sender: Any) {
    }
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addtaskTextField.delegate = self
    }
}

// MARK: - TextField fields
extension GoalSettingVC: UITextFieldDelegate {
    
    // MARK: - TextField properties
    
    // MARK: - TextField methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addtaskTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

