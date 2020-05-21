# Genesis

[![CI Status](https://img.shields.io/travis/261930323@qq.com/Genesis.svg?style=flat)](https://travis-ci.org/261930323@qq.com/Genesis)
[![Version](https://img.shields.io/cocoapods/v/Genesis.svg?style=flat)](https://cocoapods.org/pods/Genesis)
[![License](https://img.shields.io/cocoapods/l/Genesis.svg?style=flat)](https://cocoapods.org/pods/Genesis)
[![Platform](https://img.shields.io/cocoapods/p/Genesis.svg?style=flat)](https://cocoapods.org/pods/Genesis)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Genesis is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Genesis'
```

## Author

261930323@qq.com, zhang_mao008@163.com

## License

Genesis is available under the MIT license. See the LICENSE file for more info.


## How to use

```ruby
import Genesis
```
## 注: Genesis 基础组件 命名空间为 g, ex : print("101".g.toInt) , 

## StringExtension

```ruby
类型转换
public var toInt : Int{}
public var toInt32 : Int32{}
public var toInt64 : Int64{}
public var toDouble : Double{}
public var toFloat : Float{}
public var toBool : Bool{}
```

```ruby
其它
/// md5加密
public var md5: String {}

/// 是否是邮箱
public var isEmail: Bool {}

/// 校验身份证
public var isUserIDCard : Bool {}

/// 是否全是数字
public var isAllInt: Bool {}

///校验姓名是否是汉字格式
public var isPureChinese : Bool {}

/// 是否是小数格式的字符串
public var isDecimal: Bool {}

/// 替代中间的字符串 abcdefg -> ab***fg
public func middleReplaced(left: Int, right: Int, with: String) -> String {}

///为银行卡号插入空格
public var insertSpaceForBank : String {}

/// 保留左右两边元素，替换中间元素
/// let stirngs = "1234567890".g.keep(left: 5, right: 3, replaced: "****")
/// Prints "12345****890"

public func keep(left: Int, right: Int, with: String) -> String {}

/// 是否含有 Emoji
public var containsEmoji: Bool {}


/// 如果有Eomji, URL转码
public var encodingForEmoji: String {}

/// 使用`URL 编码对字符串`Emoji`进行转码
/// 不转码非Emoji字符
public func switchEmojiToPercent() -> String {}


/// 抛弃最后无用的 `0`
/// let string = "739124.083000"
/// Prints "739124.083"
public var drop_0: String {}


/// 获取首个字符的字母
/// 王: w; 李: l
public var first_alphabet: String {}

/// 校验是否正确格式密码
public func passwordFormat(_ min: Int = 8, _ maxCover: Int = 15) -> FMError? {}
```


## ArrayExtension
```ruby
/// 获取第二/三个元素
public var second: Self.Element? {}
public var third: Self.Element? {}


/// 是否为空，则为 `nil`
/// 如果不为空 则返回 `self`
public var nonEmpty: Self? {}


/// 保留左右两边元素，替换中间元素
///
///     let stirngs = Array("1234567890").g.keep(left: 5, right: 3, replaced: "****")
///     print(stirngs)
///     // Prints "["1", "2", "3", "4", "5", "*", "*", "*", "*", "8", "9", "0"]"
///
///     let ints = [4].g.keep(left: 9, right: 3, replaced: [1,5]))
///     print(ints)
///     // Prints "[4, 1, 5]"
///
///     let empty = [Int]().g.keep(left: -10, right: 3, replaced: [1,2,3,4,5])
///     print(empty)
///     // Prints "[1, 2, 3, 4, 5]"
///
///     let intss = [1,4].g.keep(left: 0, right: 1, replaced: [1,2,3,4,5]))
///     print(intss)
///     // Prints "[1, 2, 3, 4, 5, 4]"
/// - Parameters:
///   - left: 左侧保留到`n`
///   - right: 右侧保留到`n`
///   - replaced: 替换物
/// - Returns: [Element]
/// - Complexity: O(m) on average, where m is the length of replaced
public func keep<S>(left: Int, right: Int, replaced: S) -> [Element] where Element == S.Element, S : Sequence {}
```

## DateExtension

```ruby
///输出 yyyy-MM-dd 格式日期
public var day : String{}

```
