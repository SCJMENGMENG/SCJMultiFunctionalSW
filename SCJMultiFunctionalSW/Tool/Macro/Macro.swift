//
//  Macro.swift
//  SCJMultiFunctionalSW
//
//  Created by scj on 2021/11/23.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
let kNavHeight = (kStatusBarHeight + 44)

func kRandomColor() -> UIColor {
    return UIColor(red: CGFloat(arc4random() % 256) / 256.0, green: CGFloat(arc4random() % 256) / 256.0, blue: CGFloat(arc4random() % 256) / 256.0, alpha: 1.0)
}

func RGB16(rgbValue:Int) -> UIColor {
    return UIColor(red:CGFloat((rgbValue & 0xFF0000) >> 16)/255.0, green: CGFloat((rgbValue & 0xFF00) >> 8)/255.0, blue: CGFloat(Float(rgbValue & 0xFF)/255.0) , alpha: 1.0)
}

//rbg转UIColor(16进制)带透明度
func RGBA16(rgbaValue:Int) -> UIColor {
    return UIColor(red:CGFloat((rgbaValue & 0xFF0000) >> 16)/255.0, green: CGFloat((rgbaValue & 0xFF00) >> 8)/255.0, blue: CGFloat(Float(rgbaValue & 0xFF)/255.0) , alpha: CGFloat((rgbaValue & 0xFF000000) >> 24)/255.0)
}

func RGBColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor.init(red: (r/255.0), green: (g/255.0), blue: (b/255.0), alpha: a)
}
 
