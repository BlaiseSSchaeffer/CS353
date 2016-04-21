//
//  TweetDetailTableViewController.swift
//  Smashtag
//
//  Created by Blaise Schaeffer on 4/6/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class TweetDetailTableViewController: UITableViewController {
    
    private var images: Mentions?
    private var hastags: Mentions?
    private var users: Mentions?
    private var urls: Mentions?
    
    var tweet: Tweet? {
        didSet {
            images = .Image(tweet!.media)
            hastags = .Hashtag(tweet!.hashtags)
            users = .User(tweet!.userMentions)
            urls = .URL(tweet!.urls)
            
            print(tweet)
            print()
            print(images!.count)
            print(hastags!.count)
            print(users!.count)
            print(urls!.count)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    // MARK: - Table view data source
    
    private enum Mentions {
        case Image([MediaItem])
        case URL([Tweet.IndexedKeyword])
        case Hashtag([Tweet.IndexedKeyword])
        case User([Tweet.IndexedKeyword])
        
        var titleForHeaderInSection: String {
            get {
                switch self {
                case .Image(_):
                    return "Images"
                case .URL(_):
                    return "URLs"
                case .Hashtag(_):
                    return "Hashtags"
                case .User(_):
                    return "Users"
                }
            }
        }
        
        var count: Int {
            get {
                switch self {
                case .Image(let media):
                    return media.count
                case .Hashtag(let hashtag):
                    return hashtag.count
                case .User(let user):
                    return user.count
                case .URL(let url):
                    return url.count
                }
            }
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
