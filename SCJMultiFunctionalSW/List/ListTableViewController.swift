//
//  ListTableViewController.swift
//  SCJMultiFunctionalSW
//
//  Created by scj on 2021/5/24.
//

import UIKit
import MGJRouter_Swift

class ListTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    var dataSource = NSArray()
    var backgroundImg = UIImageView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ListRouter.shared.register()
        
        self.initData()
        self.setViews()
        self.tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kStatusBarHeight))
    }
    
    func initData() -> Void {
        self.dataSource = ListModel.getListDataModel()
    }
    
    func setViews() -> Void {
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.tableFooterView = UIView.init(frame: CGRect(x: 0,y: 0,width: 0,height: 0.1))
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: ListModel.className())
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListModel.className(), for: indexPath)
        
        let model: ListModel = self.dataSource[indexPath.row] as! ListModel
        cell.textLabel?.text = model.title
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model: ListModel = self.dataSource[indexPath.row] as! ListModel
        model.index = indexPath.row
        let selector = Selector(model.cellClick)
        self.perform(selector, with: model, with: model)
    }
    
    // MARK: openScheme
    @objc func openScheme(_ model: ListModel, _ model1: ListModel) -> Void {
        print("---routerScheme", model.title,model1.routerScheme)
        
        MGJRouter.open(model.routerScheme,["key":"value"],nil)
    }
}

