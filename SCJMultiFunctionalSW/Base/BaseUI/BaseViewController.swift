//
//  BaseViewController.swift
//  SCJMultiFunctionalSW
//
//  Created by scj on 2021/11/17.
//

import UIKit

class BaseViewController: UIViewController {
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        self.navigationController?.navigationBar.isHidden = false
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(true)
//        self.navigationController?.navigationBar.isHidden = true
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBaseNavigationBar()
    }
    
    func setupBaseNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor.white), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let lineView = UIView.init(frame: CGRect.init(x: 0, y: (self.navigationController?.navigationBar.size.height)! - 1, width: (self.navigationController?.navigationBar.size.width)!, height: 20))
        
        lineView.backgroundColor = UIColor.init(hexString: "EEEEEE")
        
        let backImg = UIImage.init(named: "nav_back_black")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: backImg, style: .plain, target: self, action: #selector(back))
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }

}
