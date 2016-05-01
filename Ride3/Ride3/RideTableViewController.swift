//
//  RideTableViewController.swift
//  Ride3
//
//  Created by Blaise Schaeffer on 4/28/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class RideTableViewController: UITableViewController {
    var rideEntries: [RideEntry] = [
        RideEntry(rideTitle: "First Ride", distance: 13),
        RideEntry(rideTitle: "Madison Loop", distance: 27),
        RideEntry(rideTitle: "Kendalville Ride", distance: 49),
        RideEntry(rideTitle: "Prairie Farm Trial", distance: 50),
        RideEntry(rideTitle: "Castalia", distance: 42),
        RideEntry(rideTitle: "Waukon Loop", distance: 53),
        RideEntry(rideTitle: "Cedar Falls and Flowers", distance: 37),
        RideEntry(rideTitle: "Reverse Inaugural", distance: 29),
        RideEntry(rideTitle: "Half a Gran", distance: 36),
        RideEntry(rideTitle: "Century Ride with Jim", distance: 105)
    ]
    
    let darkGreyBackgroundColor: UIColor = UIColor(colorLiteralRed: 66/255, green: 66/255, blue: 66/255, alpha: 1.0)
    
    
    
    private struct Storyboard {
        static let CellReuseIdentifier = "RideEntryCell"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = darkGreyBackgroundColor
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rideEntries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! RideEntryTableViewCell
        let entry = rideEntries[indexPath.row]
        
        cell.configure(entry)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        rideEntries.removeAtIndex(indexPath.row)
        print(rideEntries)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dvc = segue.destinationViewController as? ViewEditEntryViewController {
            if let rideEntryCell = sender as? RideEntryTableViewCell {
                dvc.rideEntry = rideEntryCell.rideEntry
                print("Here", rideEntryCell.rideEntry)
            }
        }
    }
}
