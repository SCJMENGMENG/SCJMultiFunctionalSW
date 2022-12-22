//
//  SCJFakeNavigationBar.swift
//  SCJMultiFunctionalSW
//
//  Created by scj on 2021/11/17.
//

import UIKit

class SCJFakeNavigationBar: UIView {

    // MARK: -  lazy load
    
    private lazy var fakeBackgroundImageView: UIImageView = {
        let fakeBackgroundImageView = UIImageView()
        fakeBackgroundImageView.isUserInteractionEnabled = false
        fakeBackgroundImageView.contentScaleFactor = 1
        fakeBackgroundImageView.contentMode = .scaleToFill
        fakeBackgroundImageView.backgroundColor = .clear
        return fakeBackgroundImageView
    }()
    
    private lazy var fakeBackgroundEffectView: UIVisualEffectView = {
        let fakeBackgroundEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        fakeBackgroundEffectView.isUserInteractionEnabled = false
        return fakeBackgroundEffectView
    }()
    
    private lazy var fakeShadowImageView: UIImageView = {
        let fakeShadowImageView = UIImageView()
        fakeShadowImageView.isUserInteractionEnabled = false
        fakeShadowImageView.contentScaleFactor = 1
        return fakeShadowImageView
    }()
    
    // MARK: -  init
    
    init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        addSubview(fakeBackgroundEffectView)
        addSubview(fakeBackgroundImageView)
        addSubview(fakeShadowImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fakeBackgroundEffectView.frame = bounds
        fakeBackgroundImageView.frame = bounds
        fakeShadowImageView.frame = CGRect(x: 0, y: bounds.height - 0.5, width: bounds.width, height: 0.5)
    }
    
    // MARK: -  public
    
    func scj_updateFakeBarBackground(for viewController: UIViewController) {
        fakeBackgroundEffectView.subviews.last?.backgroundColor = viewController.scj_backgroundColor
        fakeBackgroundImageView.image = viewController.scj_backgroundImage
        if viewController.scj_backgroundImage != nil {
            // 直接使用fakeBackgroundEffectView.alpha控制台会有提示
            // 这样使用避免警告
            fakeBackgroundEffectView.subviews.forEach { (subview) in
                subview.alpha = 0
            }
        } else {
            fakeBackgroundEffectView.subviews.forEach { (subview) in
                subview.alpha = viewController.scj_barAlpha
            }
        }
        fakeBackgroundImageView.alpha = viewController.scj_barAlpha
        fakeShadowImageView.alpha = viewController.scj_barAlpha
    }
    
    func scj_updateFakeBarShadow(for viewController: UIViewController) {
        fakeShadowImageView.isHidden = viewController.scj_shadowHidden
        fakeShadowImageView.backgroundColor = viewController.scj_shadowColor
    }

}
