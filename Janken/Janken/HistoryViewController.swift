//
//  HistoryViewController.swift
//  Janken
//
//  Created by Guilherme Silva on 07/08/16.
//  Copyright © 2016 Guilherme B G Silva. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var history = []
    
    @IBOutlet weak var tableView: UITableView!
    let CELL_IDENTIFIER = "historyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let historyDefaults = defaults.arrayForKey("history") {
            history = historyDefaults.reverse()
        }
    }
    
    @IBAction func okButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CELL_IDENTIFIER)!
        let result = history.objectAtIndex(indexPath.row) as! Dictionary<String, String>
        
        cell.textLabel?.text = result["title"]
        cell.detailTextLabel?.text = result["detail"]
        
        
        return cell
    }
}