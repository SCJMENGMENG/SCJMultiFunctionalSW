//
//  UIViewController+TopMost.swift
//  SCJMultiFunctionalSW
//
//  Created by scj on 2021/11/16.
//

import UIKit

extension UIViewController {
    
    //获取顶部控制器
    public class func topMost() -> UIViewController? {
        var window = UIApplication.shared.keyWindow
        //是否为当前显示的window
        if (window?.windowLevel.rawValue) != 0 {
            let windows = UIApplication.shared.windows
            for windowTemp in windows {
                if windowTemp.windowLevel.rawValue == 0 {
                    window = windowTemp
                    break
                }
            }
        }
        
        let vc = window?.rootViewController
        return _topViewController(withCurrentVC: vc)
    }
    
    public class func _topViewController(withCurrentVC vc:UIViewController?) -> UIViewController? {
        if vc == nil {
            return nil
        }
        if let presetnVC = vc?.presentedViewController {
            return _topViewController(withCurrentVC: presetnVC)
        }
        else if let nav = vc as? UINavigationController {
            return _topViewController(withCurrentVC: nav.visibleViewController)
        }
        else if let tabv = vc as? UITabBarController {
            if let selectVC = tabv.selectedViewController {
                return _topViewController(withCurrentVC: selectVC)
            }
            return nil
        }
        else {
            return vc
        }
    }
}

// MARK: -  自定义导航栏相关的属性, 支持UINavigationBar.appearance()
extension UIViewController {
    // MARK: -  属性
    
    /// keys
    private struct SCJNavigationBarKeys {
        static var barStyle = "NavigationBarKeys_barStyle"
        static var backgroundColor = "NavigationBarKeys_backgroundColor"
        static var backgroundImage = "NavigationBarKeys_backgroundImage"
        static var tintColor = "NavigationBarKeys_tintColor"
        static var barAlpha = "NavigationBarKeys_barAlpha"
        static var titleColor = "NavigationBarKeys_titleColor"
        static var titleFont = "NavigationBarKeys_titleFont"
        static var shadowHidden = "NavigationBarKeys_shadowHidden"
        static var shadowColor = "NavigationBarKeys_shadowColor"
        static var enablePopGesture = "NavigationBarKeys_enablePopGesture"
    }

    /// 导航栏样式，默认样式
    var scj_barStyle: UIBarStyle {
        get {
            return objc_getAssociatedObject(self, &SCJNavigationBarKeys.barStyle) as? UIBarStyle ?? UINavigationBar.appearance().barStyle
        }
        set {
            objc_setAssociatedObject(self, &SCJNavigationBarKeys.barStyle, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            scj_setNeedsNavigationBarTintUpdate()
        }
    }
    
    /// 导航栏前景色（item的文字图标颜色），默认黑色
    var scj_tintColor: UIColor {
        get {
            if let tintColor = objc_getAssociatedObject(self, &SCJNavigationBarKeys.tintColor) as? UIColor {
                return tintColor
            }
            if let tintColor = UINavigationBar.appearance().tintColor {
                return tintColor
            }
            return .black
        }
        set {
            objc_setAssociatedObject(self, &SCJNavigationBarKeys.tintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            scj_setNeedsNavigationBarTintUpdate()
        }
    }
    
    
    /// 导航栏标题文字颜色，默认黑色
    var scj_titleColor: UIColor {
        get {
            if let titleColor = objc_getAssociatedObject(self, &SCJNavigationBarKeys.titleColor) as? UIColor {
                return titleColor
            }
            if let titleColor = UINavigationBar.appearance().titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor {
                return titleColor
            }
            return .black
        }
        set {
            objc_setAssociatedObject(self, &SCJNavigationBarKeys.titleColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            scj_setNeedsNavigationBarTintUpdate()
        }
    }
    
    /// 导航栏标题文字字体，默认17号粗体
    var scj_titleFont: UIFont {
        get {
            if let titleFont = objc_getAssociatedObject(self, &SCJNavigationBarKeys.titleFont) as? UIFont {
                return titleFont
            }
            if let titleFont = UINavigationBar.appearance().titleTextAttributes?[NSAttributedString.Key.font] as? UIFont {
                return titleFont
            }
            return UIFont.boldSystemFont(ofSize: 17)
        }
        set {
            objc_setAssociatedObject(self, &SCJNavigationBarKeys.titleFont, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            scj_setNeedsNavigationBarTintUpdate()
        }
    }
    
    
    /// 导航栏背景色，默认白色
    var scj_backgroundColor: UIColor {
        get {
            if let backgroundColor = objc_getAssociatedObject(self, &SCJNavigationBarKeys.backgroundColor) as? UIColor {
                return backgroundColor
            }
            if let backgroundColor = UINavigationBar.appearance().barTintColor {
                return backgroundColor
            }
            return .white
        }
        set {
            objc_setAssociatedObject(self, &SCJNavigationBarKeys.backgroundColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            scj_setNeedsNavigationBarBackgroundUpdate()
        }
    }
    
    /// 导航栏背景图片
    var scj_backgroundImage: UIImage? {
        get {
            return objc_getAssociatedObject(self, &SCJNavigationBarKeys.backgroundImage) as? UIImage ?? UINavigationBar.appearance().backgroundImage(for: .default)
        }
        set {
            objc_setAssociatedObject(self, &SCJNavigationBarKeys.backgroundImage, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            scj_setNeedsNavigationBarBackgroundUpdate()
        }
    }
    
    /// 导航栏背景透明度，默认1
    var scj_barAlpha: CGFloat {
        get {
            return objc_getAssociatedObject(self, &SCJNavigationBarKeys.barAlpha) as? CGFloat ?? 1
        }
        set {
            objc_setAssociatedObject(self, &SCJNavigationBarKeys.barAlpha, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            scj_setNeedsNavigationBarBackgroundUpdate()
        }
    }

    /// 导航栏底部分割线是否隐藏，默认不隐藏
    var scj_shadowHidden: Bool {
        get {
            return objc_getAssociatedObject(self, &SCJNavigationBarKeys.shadowHidden) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &SCJNavigationBarKeys.shadowHidden, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            scj_setNeedsNavigationBarShadowUpdate()
        }
    }
    
    /// 导航栏底部分割线颜色
    var scj_shadowColor: UIColor {
        get {
            return objc_getAssociatedObject(self, &SCJNavigationBarKeys.shadowColor) as? UIColor ?? UIColor(white: 0, alpha: 0.3)
        }
        set {
            objc_setAssociatedObject(self, &SCJNavigationBarKeys.shadowColor, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            scj_setNeedsNavigationBarShadowUpdate()
        }
    }
    
    /// 是否开启手势返回，默认开启
    var scj_enablePopGesture: Bool {
        get {
            return objc_getAssociatedObject(self, &SCJNavigationBarKeys.enablePopGesture) as? Bool ?? true
        }
        set {
            objc_setAssociatedObject(self, &SCJNavigationBarKeys.enablePopGesture, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    // MARK: -  更新UI

    // 整体更新
    func scj_setNeedsNavigationBarUpdate() {
        guard let naviController = navigationController as? SCJNavigationController else { return }
        naviController.scj_updateNavigationBar(for: self)
    }
    
    // 更新文字、title颜色
    func scj_setNeedsNavigationBarTintUpdate() {
        guard let naviController = navigationController as? SCJNavigationController else { return }
        naviController.scj_updateNavigationBarTint(for: self)
    }

    // 更新背景
    func scj_setNeedsNavigationBarBackgroundUpdate() {
        guard let naviController = navigationController as? SCJNavigationController else { return }
        naviController.scj_updateNavigationBarBackground(for: self)
    }
    
    // 更新shadow
    func scj_setNeedsNavigationBarShadowUpdate() {
        guard let naviController = navigationController as? SCJNavigationController else { return }
        naviController.scj_updateNavigationBarShadow(for: self)
    }
}

//动态icon
extension DispatchQueue {
    private static var _onceTracker = [String]()
    public class func once(token: String, block: () -> ()) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
}

extension UIViewController {
    public class func initializeMethod() {
        if self != UIViewController.self {
            return
        }
        
        //Method Swizzling
        DispatchQueue.once(token: "dyIcon") {
            let orignal = class_getInstanceMethod(self, #selector(UIViewController.present(_:animated:completion:)))
            let swizzling = class_getInstanceMethod(self, #selector(UIViewController.scj_present(_:animated:completion:)))
            
            if let old = orignal, let new = swizzling {
                method_exchangeImplementations(old, new)
            }
        }
    }
    
    @objc private func scj_present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        //判断是否是更换icon时的弹框
        if viewControllerToPresent is UIAlertController {
            let alertTitle = (viewControllerToPresent as! UIAlertController).title
            let alertMessage = (viewControllerToPresent as! UIAlertController).message
            
            //更换icon时的弹出框
            if alertTitle == nil && alertMessage == nil {
                return
            }
        }
        
        self.scj_present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
