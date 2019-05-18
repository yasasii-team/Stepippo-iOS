//
//  IPPO.swift
//  Stepippo
//
//  Created by ないぱか on 2019/05/18.
//  Copyright © 2019 Yasasii-kai. All rights reserved.
//

import Foundation
import RealmSwift

enum IPPOStatus: String {
    case stock // 後でやる
    case challenging // 挑戦中
    case performed  // 達成見込
    case achieved // 達成済み
}

@objcMembers
class IPPO: Object {
    // 一意のID
    dynamic var id = 0
    
    // タスクの名前
    dynamic var title = ""
    
    // 進捗状態
    dynamic private var ippoStatus = ""
    
    // タスク追加日時
    dynamic var addDateTime = Date()
    
    // タスク実施日時
    dynamic var performedDateTime: Date?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    var status: IPPOStatus {
        get {
            return IPPOStatus(rawValue: ippoStatus)!
        }
        set {
            ippoStatus = newValue.rawValue
        }
    }
}
