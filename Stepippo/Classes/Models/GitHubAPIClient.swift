//
//  GitHubAPIClient.swift
//  Stepippo
//
//  Created by 村松龍之介 on 2019/04/20.
//  Copyright © 2019 Yasasii-kai. All rights reserved.
//

import Foundation

struct GitHubAPIClient {
    
    enum IssueType {
        case bug
        case enhancement
    }
    
    private static let repository = "https://api.github.com/repos/yasasii-team/Stepippo-iOS/"
    
    /// 指定したラベルのIssueを[GitHub REST API]を使用して取得する
    static func getIssues(type issueType: IssueType, callback: @escaping ([GitHubIssue]) -> Void) {
        
        print(issueType)
        let url = URL(string: "\(repository)issues?labels=\(issueType)&sort=updated")!

        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("エラーが発生しました: \(error)")
                return
            }
            guard let data = data else {
                print("データが見つかりません")
                return
            }
            do {
                let decoder = JSONDecoder()
                // 用意した構造体に合わせて、JSONのキーのスネークケースをキャメルケースに変換する
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                // データの形式をJSONからGitHubIssueに変換する
                let issues = try decoder.decode([GitHubIssue].self, from: data)
                callback(issues)
                
            } catch let error {
                print("エラーが発生しました: \(error)")
            }
        }
        dataTask.resume()
    }
}
