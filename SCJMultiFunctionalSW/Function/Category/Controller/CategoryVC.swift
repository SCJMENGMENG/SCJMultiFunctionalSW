//
//  CategoryVC.swift
//  SCJMultiFunctionalSW
//
//  Created by scj on 2021/11/24.
//

import UIKit
import JXSegmentedView

class CategoryVC: UIViewController {
    
    var segmentedDataSource = JXSegmentedBaseDataSource()
    let segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    let lineView = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = kRandomColor()
        scj_barAlpha = 0
        scj_tintColor = .clear
        scj_titleColor = .clear
        scj_barStyle = .default
        
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = ["王者","大师","钻石"]
        dataSource.titleNormalColor = RGB16(rgbValue: 0x222222)
        dataSource.titleSelectedColor = RGB16(rgbValue: 0x527AFF)
        
        segmentedDataSource = dataSource
        
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 24
        indicator.indicatorHeight = 3;
        indicator.indicatorColor = RGB16(rgbValue: 0x527AFF)
        
        let indicator1 = JXSegmentedIndicatorLineView()
        indicator1.indicatorWidth = 10
        indicator1.indicatorHeight = 10
        indicator1.indicatorColor = .red
        
        let indicator2 = JXSegmentedIndicatorLineView()
        indicator2.indicatorWidth = 15
        indicator2.indicatorHeight = 7
        indicator2.indicatorColor = .cyan
        
        segmentedView.indicators = [indicator,indicator1,indicator2]
        
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        view.addSubview(segmentedView)
        
        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)
        
        let backBtn = UIButton()
        backBtn.backgroundColor = kRandomColor()
        backBtn.setTitle("back", for: UIControl.State.normal)
        backBtn.frame = CGRect.init(x: 0, y: kStatusBarHeight, width: 44, height: 44)
        backBtn.addTarget(self, action: #selector(backButtonClicked), for: UIControl.Event.touchUpInside)
        self.view.addSubview(backBtn)
        
        lineView.backgroundColor = .white
        self.segmentedView.addSubview(lineView)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)

        //处于第一个item的时候，才允许屏幕边缘手势返回
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)

        //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        segmentedView.frame = CGRect(x: 0, y: kStatusBarHeight, width: view.bounds.size.width, height: 45)
        listContainerView.frame = CGRect(x: 0, y: (kStatusBarHeight + 45), width: view.bounds.size.width, height: view.bounds.size.height - 45 - kStatusBarHeight)
        lineView.frame = CGRect.init(x: 0, y: 44, width: kScreenWidth, height: 1)
    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CategoryVC: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            //先更新数据源的数据
            dotDataSource.dotStates[index] = false
            //再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
        }

        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
}

extension CategoryVC: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        if index == 0 {
            return CategoryListVC()
        }
        else {
            return SunVC.init()
        }
    }
}
