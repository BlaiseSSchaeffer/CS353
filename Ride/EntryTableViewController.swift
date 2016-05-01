//
//  EntryTableViewController.swift
//  Ride
//
//  Created by Blaise Schaeffer on 4/26/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class EntryTableViewController: UITableViewController {

    @IBOutlet weak var headerView: UIView!
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    
//    @IBAction func addButton() {
//        print("Adding a Ride")
//    }

}
