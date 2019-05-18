//
//  IPPO.swift
//  Stepippo
//
//  Created by ないぱか on 2019/05/18.
//  Copyright © 2019 Yasasii-kai. All rights reserved.
//

import Foundation
import RealmSwift

class IPPO: Object {
    // 一意のID
    dynamic var id = 0
    
    // タスクの名前
    dynamic var title = ""
    
    // 進捗状態
    // 後でやる："stock", 挑戦中："challenging", 達成見込："performed", 達成済み："achieved"
    dynamic var status = ""
    
    // タスク追加日時
    dynamic var addDateTime: Date?
    
    // タスク実施日時
    dynamic var performedDateTime: Date?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
