//
//  ViewController.swift
//  PullToRefresh
//
//  Created by tbago on 2019/2/25.
//  Copyright © 2019年 tbago. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    var dataSrouce = Array<Date>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新")
        refreshControl.addTarget(self, action: #selector(pullToRefeshAction), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
    }

    @objc func pullToRefeshAction() {
        let date = NSDate()
        print(date)
        print(date.addingTimeInterval(60))
        ///< https://stackoverflow.com/questions/39811352/swift-3-date-vs-nsdate
        dataSrouce.insert(Date(), at: 0)
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSrouce.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "PullToRefreshTableViewCell", for: indexPath)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日/HH时mm分ss秒"
        let formatString = dateFormatter.string(from: dataSrouce[indexPath.row]);
        tableCell.textLabel?.text = formatString
        
        return tableCell
    }
}

