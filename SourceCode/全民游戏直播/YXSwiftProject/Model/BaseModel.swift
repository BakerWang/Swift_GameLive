//
//  BaseModel.swift
//  YXSwiftProject
//
//  Created by jiyingxin on 16/3/17.
//  Copyright © 2016年 jiyingxin. All rights reserved.
//

import UIKit

protocol BaseModelProtocol {
    //数组对应的特殊解析类
    static func propertyNameForKey(key: String) -> String
    //特殊key对应
    static func objectClassForKey(key: String) -> AnyClass?

}

extension String{
    
    //love_me -> loveMe
    var upperWords: String{
        let tmpArr = self.componentsSeparatedByString("_")
        var tmpStr = ""
        
        for var str in tmpArr {
            
            str = str.uppercaseString
            tmpStr += str
        }
        return tmpStr
    }
    
    
    
}

class BaseModel: NSObject, BaseModelProtocol {

    override func setNilValueForKey(key: String) {
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    
    class func parse(responseObj: AnyObject) -> AnyObject {
        if responseObj is [String: AnyObject] {
            return self.parseDic(responseObj as! [String: AnyObject])
        }
        if responseObj is [AnyObject] {
            return self.parseArr(responseObj as! [AnyObject])
        }
        return responseObj
    }
    
    static func propertyNameForKey(key: String) -> String {
        return key.upperWords
    }
    
    static func objectClassForKey(key: String) -> AnyClass? {
        return nil
    }
    
    class func parseDic(dic: [String: AnyObject]) -> AnyObject{
        let obj = super.init()
//        obj.setValuesForKeysWithDictionary(dic)
        for (key, value) in dic {
            let tmpKey = self.propertyNameForKey(key)
            var tmpObj = value
            if let tmpClass = self.objectClassForKey(tmpKey){
                tmpObj = tmpClass.parse(value)
            }
            obj.setValue(tmpObj, forKey: tmpKey)
        }
        return obj
    }
    
    class func parseArr(arr: [AnyObject])->NSArray{
        var tmpList = [AnyObject]()
        for obj in arr {
            tmpList.append(self.parse(obj))
        }
        return tmpList
    }
    

    
}
