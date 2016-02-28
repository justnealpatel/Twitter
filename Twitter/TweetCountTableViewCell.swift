//
//  TweetCountTableViewCell.swift
//  Twitter
//
//  Created by Neal Patel on 2/27/16.
//  Copyright © 2016 Neal Patel. All rights reserved.
//

import UIKit

var retweet = Int()
var likes = Int()
var thisTweet: Tweet!
var tweetText = ""

class TweetCountTableViewCell: UITableViewCell {

    @IBOutlet weak var likesText: UILabel!
    @IBOutlet weak var retweetText: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBAction func likePressed(sender: AnyObject) {
        if (thisTweet.favorited!) {
            TwitterClient.sharedInstance.destroyFav(thisTweet.id!)
            thisTweet.favoritesCount--
            thisTweet.favorited = false
        } else {
            TwitterClient.sharedInstance.createFav(thisTweet.id!)
            thisTweet.favoritesCount++
            thisTweet.favorited = true
        }
        
        likesLabel.text = "\(thisTweet.favoritesCount)"
    }
    
    @IBAction func retweetPressed(sender: AnyObject) {
        if (thisTweet.retweeted!) {
            TwitterClient.sharedInstance.unretweet(thisTweet.id!)
            thisTweet.retweetCount--
            thisTweet.retweeted = false
        } else {
            TwitterClient.sharedInstance.retweet(thisTweet.id!)
            thisTweet.retweetCount++
            thisTweet.retweeted = true
            print("\(thisTweet.id!)")
        }
        retweetLabel.text = "\(thisTweet.retweetCount)"
    }

    @IBAction func replyPressed(sender: AnyObject) {
        tweetText = "@\(((dictionary["user"]!)["screen_name"]!)!) "
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
