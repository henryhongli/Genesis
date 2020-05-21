//
//  DecimalExtension.swift
//  Genesis_Example
//
//  Created by 洪利 on 2020/5/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
extension Decimal : GenesisProvider{}

extension GEN where Base == Decimal{
    
    /// 随机补充尾数, 如果小数位为0或者已有小数 则不补充
    /// - Parameter position: 小数点保留数
    public func randomTail(_ position: Int = 2)-> Decimal{
        guard position > 0 else {
            print("Decimal转换, 传入 position 为非正整数")
            return 0
        }
        if drop_0.contains("."){ return base}
        let a = pow(10, Double(position))
        let r = Double.random(in: 1..<(a - 1))
        let i = Decimal(floatLiteral: r / a)
        return base + i
        
    }
    
    /// 补全小数点精度, 2位
    public var descStr: String {
           return format().string(from: NSDecimalNumber(decimal: base)) ?? ""
       }
    
    private func format(_ position: Int = 2) -> NumberFormatter {
        let format = NumberFormatter()
        
        format.maximumFractionDigits = position
        
        format.minimumFractionDigits = position
        
        format.numberStyle = .decimal
        
        format.generatesDecimalNumbers = true
        
        format.formatterBehavior = .behavior10_4
        return format
    }
    
    /// 抛弃最后无用的 `0`
    private var drop_0: String {
        return descStr.g.drop_0
    }
   
}


