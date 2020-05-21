//
//  StringsExtesion.swift
//  Genesis_Example
//
//  Created by 洪利 on 2020/5/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import UIKit
import Foundation
import CommonCrypto
extension String: GenesisProvider{}
extension GEN where Base == String{
    
    
    //MARK-数据类型转换
    public var toInt : Int{
        return Int((self.base as NSString).intValue)
    }
    public var toInt32 : Int32{
        return Int32((self.base as NSString).integerValue)
    }
    public var toInt64 : Int64{
        return Int64((self.base as NSString).longLongValue)
    }
    public var toDouble : Double{
        return (self.base as NSString).doubleValue
    }
    public var toFloat : Float{
        return (self.base as NSString).floatValue
    }
    public var toBool : Bool{
        if self.base.g.toInt < 0 {
            return false
        }
        return (self.base as NSString).boolValue
    }
    
    //MARK - MD5加密
    
    /// md5 加密 32位【小】
    ///
    /// - Returns: md5字符串
    public var md5: String { return Md5(self.base) }
    
    
    //MARK - 字符串扩展
    /// 是否是邮箱
    public var isEmail: Bool { return NSPredicate(format: "SELF MATCHES %@", "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$").evaluate(with: self.base) }
    /// 校验身份证
    public var isUserIDCard : Bool {
        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self.base)
        return isMatch
    }
    
    /// 是否全是数字
    public var isAllInt: Bool {
        var v: Int = 0
        let s = Scanner(string: self.base)
        return s.scanInt(&v) && s.isAtEnd
    }
    ///校验姓名是否是汉字格式
    public var isPureChinese : Bool {
        let value = NSPredicate(format: "SELF matches %@", "[\\u4e00-\\u9fa5]+$")
        return value.evaluate(with: self.base)
    }
    
    /// 是否是小数格式的字符串
    public var isDecimal: Bool {
        let scanner = Scanner(string: self.base)
        var decimal: Decimal = 0
        return scanner.scanDecimal(&decimal) && scanner.isAtEnd
    }
    
    /// 替代中间的字符串 abcdefg -> ab***fg
    public func middleReplaced(left: Int, right: Int, with: String) -> String {
        var replace = Array(self.base)
        replace.replaceMiddle(left: left, right: right, with: Array(with))
        return String(replace)
    }
    
    ///为银行卡号插入空格
    public var insertSpaceForBank : String {
        
        var text = self.base
        var newText = ""
        
        while text.count > 0 {
            let subString = text[text.startIndex..<text.index(text.startIndex, offsetBy: min(text.count, 4))]//.substring(to: text!.index(text!.startIndex, offsetBy: 4))
            
            newText += subString
            
            let a = text.index(text.startIndex, offsetBy: min(text.count, 4))
            
            let ag = text[a..<text.endIndex]
            
            if subString.count == 4 && ag.count > 0 { newText += " " }
            
            text = String(ag)
        }
        
        return newText
    }
    
    /// 保留左右两边元素，替换中间元素
    ///
    ///     let stirngs = "1234567890".keep(left: 5, right: 3, replaced: "****")
    ///     print(stirngs)
    ///     // Prints "12345****890"
    /// - Parameters:
    ///   - left: 左侧保留到`n`
    ///   - right: 右侧保留到`n`
    ///   - replaced: 替换物
    /// - Returns: [Element]
    /// - Complexity: O(m) on average, where m is the length of replaced
    public func keep(left: Int, right: Int, with: String) -> String {
        return String(Array(self.base).keep(left: left, right: right, replaced: with))
    }
    
    /// 是否含有 Emoji
    public var containsEmoji: Bool {
        var contains: Bool = false
        for char in self.base {
            if char.g.isEmoji {
                contains.toggle()
                break
            }
        }
        return contains
    }
    
    
    /// 如果有Eomji, URL转码
    public var encodingForEmoji: String {
        if containsEmoji { return switchEmojiToPercent() }
        return self.base
    }
    
    /// 使用`URL 编码对字符串`Emoji`进行转码
    /// 不转码非Emoji字符
    public func switchEmojiToPercent() -> String {
    
        var new = Array(self.base).map { String($0) }
        
        for (index, char) in self.base.enumerated() {
            
            if char.g.isEmoji {
                let string = String(char)
                let un = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                new[index] = un
            }
            
        }

        return new.joined()
    }
    
    
    /// 抛弃最后无用的 `0`
    ///
    ///     let string = "739124.083000"
    ///     print(string)
    ///     // Prints "739124.083"
    ///     ----------------------------
    ///     let string1 = "739124."
    ///     print(string1)
    ///     // Prints "739124"
    ///
    /// - Complexity: O(n)
    public var drop_0: String {
        return drop_0(self.base)
    }
    
    /// 抛弃最后无用的 `0`
    private func drop_0(_ value: String) -> String {
        /// 如果不包含`.`或者为空，终止条件
        guard value.contains("."), let last = value.last else { return value }
        
        var new = value
        
        switch last {
        case ".", "0": new.removeLast()
        default: return value
        }
        
        return drop_0(new)
    }
    
    /// 获取首个字符的字母
    ///
    /// discussion:
    ///          - 王: w; 李: l
    ///          - $王: $
    ///          - `如果非法字符`: #
    public var first_alphabet: String {
        
        guard base.nonEmpty != nil else {
            return "#"
        }
        
        let c = CFStringCreateMutableCopy(nil, 0, base as CFString)
        
        CFStringTransform(c, nil, kCFStringTransformToLatin, false)
        
        CFStringTransform(c, nil, kCFStringTransformStripCombiningMarks, false)
        
        guard let value = CFStringCreateWithSubstring(nil, c, CFRangeMake(0, 1)) else { return "#" }
        
        return String(value)
        
    }

    
    /// 错误提示  长度, 格式, 限制条件不符
    public enum FMError {
            case length, form, limit
        }
    
    /// 校验是否正确格式密码
    /// - Parameters:
    ///   - min: 最小长度
    ///   - maxCover: 最大长度(包含)
    /// - Returns: 错误信息
    public func passwordFormat(_ min: Int = 8, _ maxCover: Int = 15) -> FMError? {
        if min <= maxCover {
            return .limit
        }
        
        if !(min..<maxCover).contains(self.base.count) {
            return .length
        }
        
        //大写字母、小写字母、数字、符号(不包括空格)其中4类选3的组合
        var format = 0
        let legal = "!"..."~"
        let number = "0"..."9"
        let lowCase = "a"..."z"
        let upCase = "A"..."Z"
        let sign1 = "!"..."/"
        let sign2 = ":"..."@"
        let sign3 = "["..."`"
        let sign4 = "{"..."~"
        
        for c in self.base {
            let str = String(c)
            if !legal.contains(str) {
                return .form
            }
            if number.contains(str) {
                format = format | 1 << 0
                continue
            }
            if lowCase.contains(str) {
                format = format | 1 << 1
                continue
            }
            if upCase.contains(str) {
                format = format | 1 << 2
                continue
            }
            if sign1.contains(str) || sign2.contains(str) || sign3.contains(str) || sign4.contains(str) {
                format = format | 1 << 3
                continue
            }
        }
        
        if format.binaryBitAddition() < 2 {
            return .form
        }
        
        return nil
    }
    
    
    
    /// md5 加密 32位【小】
    ///
    /// - Parameter str: 需要加密的字符串
    /// - Returns: md5字符串
    private func Md5(_ str: String) -> String {
        if str.isEmpty { return "" }
        
        let cchar = str.cString(using: .utf8)! // [CChar]
        let k = str.lengthOfBytes(using: .utf8) // Int
        let strLen = CUnsignedInt(k)
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        defer {
            result.deinitialize(count: digestLen)
        }
        
        CC_MD5(cchar, strLen, result)
        
        var final = ""
        for i in 0 ..< digestLen {
            final = final.appendingFormat("%02x", result[i])
        }
        return final
    }
}
extension Int {
    
    fileprivate func binaryBitAddition() -> Int {
        var num: Int = self
        var count:Int = 0
        while num > 0 {
            count += 1
            num = num & (num-1)
        }
        return count
    }
}
extension Character: GenesisProvider{}
extension GEN where Base == Character {
    
    /// 是否是Emoji
    fileprivate var isEmoji: Bool {
        for scalar in self.base.unicodeScalars {
            switch scalar.value {
            case
            0x00A0...0x00AF,
            0x2030...0x204F,
            0x2120...0x213F,
            0x2190...0x21AF,
            0x2310...0x329F,
            0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }
}









