//
//  Int+Extension.swift
//  Stepippo
//
//  Created by 村松龍之介 on 2019/05/13.
//  Copyright © 2019 Yasasii-kai. All rights reserved.
//

extension Int {
    
    /// +1した数値を返す
    var incremented: Int {
        return self + 1
    }
    
    /// -1した数値を返す
    var decremented: Int {
        return self - 1
    }
    
    /// 自らに1を足す
    mutating func increment() {
        self = self.incremented
    }
    
    /// 自らから1減らす
    mutating func decrement() {
        self = self.decremented
    }
}
