//
//  DateExtension.swift
//  Genesis_Example
//
//  Created by 洪利 on 2020/5/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
extension Date : GenesisProvider{}
extension GEN where Base == Date{
    
    /// 转换 为 年-月-日格式
    public var day : String{
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self.base)
    }
    
    
    
    
    
}


