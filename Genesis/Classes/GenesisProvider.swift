//
//  GenesisProvider.swift
//  Genesis_Example
//
//  Created by 洪利 on 2020/5/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//





//MARK- 命名空间声明
public protocol GenesisProvider{}


public struct GEN<Base>{
    public let base : Base
    fileprivate init (_ base: Base){
        self.base = base
    }
}


extension GenesisProvider{
    public var g: GEN<Self>{
        return GEN(self)
    }
    public static var G: GEN<Self>.Type{
        return GEN<Self>.self
    }
}





