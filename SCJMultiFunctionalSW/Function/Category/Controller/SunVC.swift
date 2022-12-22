//
//  SunVC.swift
//  SCJMultiFunctionalSW
//
//  Created by scj on 2021/11/26.
//

import UIKit
import JXSegmentedView

class SunVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = kRandomColor()
    }
}

extension SunVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
