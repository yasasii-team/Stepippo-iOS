//
//  GitHubIssue.swift
//  Stepippo
//
//  Created by 村松龍之介 on 2019/04/20.
//  Copyright © 2019 Yasasii-kai. All rights reserved.
//

struct GitHubIssue: Codable {
    var htmlUrl: String // Snakecaseから変換するのでURLではなくUrl
    var title: String
    var createdAt: String
    var updatedAt: String
    var assignee: Assignee?
    
    struct Assignee: Codable {
        var avatarUrl: String
    }
}
