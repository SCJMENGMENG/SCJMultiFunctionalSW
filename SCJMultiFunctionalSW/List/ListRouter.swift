//
//  ListRouter.swift
//  SCJMultiFunctionalSW
//
//  Created by scj on 2021/11/16.
//

import UIKit
import MGJRouter_Swift

class ListRouter: NSObject {
    static let shared = ListRouter()
    
    func register() {
        MGJRouter.registerWithHandler(OpenDyIconScheme as String) { (routerParameters) in
           print("routerParameters:\(routerParameters ?? [:])")
        
            let dyLogo = DynamicLogoVC()
            UIViewController.topMost()?.navigationController?.pushViewController(dyLogo, animated: true)
        }
        
        MGJRouter.registerWithHandler(OpenCategoryScheme as String) { (routerParameters) in
           print("routerParameters:\(routerParameters ?? [:])")
        
            let categoryVC = CategoryVC()
            UIViewController.topMost()?.navigationController?.pushViewController(categoryVC, animated: true)
        }
    }
}
