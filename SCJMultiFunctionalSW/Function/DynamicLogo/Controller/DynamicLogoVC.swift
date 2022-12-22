//
//  DynamicLogoVC.swift
//  SCJMultiFunctionalSW
//
//  Created by scj on 2021/11/16.
//

import UIKit

class DynamicLogoVC: UIViewController {
    
    var selectedSelector: Selector?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.cyan
        self.initUI()
    }
    
    func initUI() {
        
        let dyIconBtn = UIButton.init()
        dyIconBtn.backgroundColor = kRandomColor()
        dyIconBtn.setTitle("动态icon", for: UIControl.State.normal)
        self.view.addSubview(dyIconBtn)
        dyIconBtn.addTarget(self, action: #selector(dyIconBtnClick), for: UIControl.Event.touchUpInside)
        
        dyIconBtn.mas_makeConstraints { (make) in
            make?.center.equalTo()(self.view)
            make?.size.mas_equalTo()(CGSize.init(width:100, height:100))
        }
    }
    
    @objc func dyIconBtnClick() {
        NSLog("-----动态icon")
        
        // FIXME: 系统版本
        if #available(iOS 10.3, *) {
            if  UIApplication.shared.supportsAlternateIcons {
                UIApplication.shared.setAlternateIconName("dyIcon") { (error) in
                    if error != nil {
                        print("更换icon错误")
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

