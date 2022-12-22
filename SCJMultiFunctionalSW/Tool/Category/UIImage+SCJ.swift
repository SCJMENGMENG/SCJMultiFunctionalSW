//
//  UIImage+SCJ.swift
//  SCJMultiFunctionalSW
//
//  Created by scj on 2021/11/17.
//

import UIKit
import Foundation

extension UIImage {
    public class func imageWithColor(color:(UIColor)) -> UIImage? {
        return self.imageWithColor(color: color, size: CGSize(width: 1, height: 1))
    }
    
    public class func imageWithColor(color:(UIColor),size:(CGSize)) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndPDFContext()
        return image!
    }
}
