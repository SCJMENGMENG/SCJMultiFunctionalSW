//
//  ListModel.swift
//  SCJMultiFunctionalSW
//
//  Created by scj on 2021/5/24.
//

import UIKit

class ListModel: NSObject {
    
    var title: String = ""
    @objc var cellClick: String = ""
    var index: NSInteger = 0
    @objc var routerScheme: String = ""
    
    class func getListDataModel() -> NSArray {
        let dataArr = NSMutableArray.init()
        
        let iconModel = ListModel.init()
        iconModel.title = "动态Icon"
        iconModel.cellClick = "openScheme::"
        iconModel.routerScheme = OpenDyIconScheme as String
        dataArr.add(iconModel)
        
        let categoryModel = ListModel.init()
        categoryModel.title = "category";
        categoryModel.cellClick = "openScheme::"
        categoryModel.routerScheme = OpenCategoryScheme as String
        dataArr.add(categoryModel)
        
        return dataArr
    }
}
