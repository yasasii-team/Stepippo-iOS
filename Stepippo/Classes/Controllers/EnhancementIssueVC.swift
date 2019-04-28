//
//  EnhancementIssueVC.swift
//  Stepippo
//
//  Created by 村松龍之介 on 2019/04/20.
//  Copyright © 2019 Yasasii-kai. All rights reserved.
//

import UIKit
import SafariServices

final class EnhancementIssueVC: UIViewController {
    
    // MARK: - IBOutlet properties
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private var issues: [GitHubIssue]?
    
    // MARK: - IBAction methods
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "機能追加・改善の予定一覧"
        
        // Cellに使うXibファイル
        tableView.register(UINib(nibName: "SubtitleAndIconCell", bundle: nil), forCellReuseIdentifier: "subtitleAndIconCell")

        GitHubAPIClient.getIssues(type: .enhancement) { [weak self] issues in
            self?.issues = issues
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - TableView data source
extension EnhancementIssueVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issues?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "subtitleAndIconCell", for: indexPath) as! SubtitleAndIconCell

        guard let issue = issues?[indexPath.row] else { return cell }
        
        let issueDateString = "作成日: \(issue.createdAt.prefix(10).description) 更新日: \(issue.updatedAt.prefix(10).description)"
        
        let avaterImage: UIImage
        // Issueにアサイニーが入ればその人のアイコンを、いなければデフォルトアイコンを使用する
        if let assignee = issue.assignee,
            let avatarURL = URL(string: assignee.avatarUrl) {
            do {
                let data = try Data(contentsOf: avatarURL)
                avaterImage = UIImage(data: data)!
                
            } catch let error {
                print("エラーが発生 : \(error)")
                avaterImage = #imageLiteral(resourceName: "GrayPerson")
            }
        } else {
            avaterImage = #imageLiteral(resourceName: "GrayPerson")
        }

        cell.configure(image: avaterImage,
                       title: issue.title,
                       subtitle: issueDateString)
        
        return cell
    }
}

// MARK: - TableView delegate
extension EnhancementIssueVC: UITableViewDelegate {
    // セルを選択した時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // アプリ内ブラウザでGitHubのIssueページを表示する
        guard let issue = issues?[indexPath.row],
            let url = URL(string: issue.htmlUrl) else { return }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
}
