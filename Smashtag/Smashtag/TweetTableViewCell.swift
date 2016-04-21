//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Blaise Schaeffer on 3/30/16.
//  Copyright © 2016 Blaise2s. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetCreatedLabel: UILabel!

    func updateUI() {
        // Reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
        tweetCreatedLabel?.text = nil
        
        // Load new information for our Tweet (if any)
        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil {
                
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
                
                let attributedText = tweetTextLabel.attributedText as? NSMutableAttributedString
                
                let users = tweet.userMentions
                let hashtags = tweet.hashtags
                let urls = tweet.urls
                                
                for user in users {
                    attributedText?.addAttributes([NSForegroundColorAttributeName : UIColor.blueColor()], range: user.nsrange)
                }
                
                for hashtag in hashtags {
                    attributedText?.addAttributes([NSForegroundColorAttributeName : UIColor.darkGrayColor()], range: hashtag.nsrange)
                }
                
                for url in urls {
                    attributedText?.addAttributes([NSForegroundColorAttributeName : UIColor.lightGrayColor()], range: url.nsrange)
                }
        
                tweetTextLabel.attributedText = attributedText
                
            }
            
            tweetScreenNameLabel?.text = "\(tweet.user)" // tweet.user.description
            
            if let profileImageURL = tweet.user.profileImageURL {
                if let imageData = NSData(contentsOfURL: profileImageURL) { // blocks main thread!
                    tweetProfileImageView?.image = UIImage(data: imageData)
                }
            }
            
            let formatter = NSDateFormatter()
            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            } else {
                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            }
            tweetCreatedLabel?.text = formatter.stringFromDate(tweet.created)
        }
    }
    
    
}
