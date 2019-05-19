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
    dynamic var id = UUID().uuidString
    
    // タスクの名前
    dynamic var title = ""
    
    // 進捗状態
    dynamic var _status = ""
    
    // タスク追加日時
    dynamic var addDateTime = Date()
    
    // タスク実施日時
    dynamic var performedDateTime: Date?
    
    var status: IPPOStatus {
        get {
            return IPPOStatus(rawValue: _status)!
        }
        set {
            _status = newValue.rawValue
        }
    }
}
