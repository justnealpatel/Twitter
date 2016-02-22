//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Neal Patel on 2/20/16.
//  Copyright © 2016 Neal Patel. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var twitterNameLabel: UILabel!
    @IBOutlet weak var datePostedTextField: UITextField!
    @IBOutlet weak var tweetContentTextView: UITextView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoritesCount: UILabel!
    @IBOutlet weak var retweetImageView: UIButton!
    
    var currentFavoriteCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func convertTimeToString(number: Int) -> String{
        let day = number/86400
        let hour = (number - day * 86400)/3600
        let minute = (number - day * 86400 - hour * 3600)/60
        if day != 0{
            return String(day) + "d"
        }else if hour != 0 {
            return String(hour) + "h"
        }else{
            return String(minute) + "m"
        }
    }
    
    var tweet: Tweet! {
        didSet {
            let dictionary = tweet.currentDictionary
            let profileURL = "\(((dictionary["user"]!)["profile_image_url_https"]!)!)"
            let URL = NSURL(string: profileURL)!
            profileImageView.setImageWithURL(URL)
            profileImageView.contentMode = .ScaleAspectFit
            let twitterHandle = "@\(((dictionary["user"]!)["screen_name"]!)!)"
            usernameLabel.text = "\(twitterHandle)"
            tweetContentTextView.text = "\(tweet.text!)"
            datePostedTextField.text = "\(tweet.timeStamp)"
            datePostedTextField.text = convertTimeToString(Int(NSDate().timeIntervalSinceDate(tweet.timeStamp!)))
            retweetCount.text = "\(tweet.retweetCount)"
            let favorites = "\(((dictionary["user"]!)["favourites_count"]!)!)"
            favoritesCount.text = favorites
            currentFavoriteCount = NSNumberFormatter().numberFromString(favorites) as! Int
            print("current fav count is \(currentFavoriteCount)")
            print("Retweet: \(tweet.retweetCount)")
            print("didSet called!")
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func retweetButtonClicked(sender: AnyObject) {
        if (tweet.retweeted!) {
            TwitterClient.sharedInstance.unretweet(tweet.id!)
            tweet.retweetCount--
            tweet.retweeted = false
        } else {
            TwitterClient.sharedInstance.retweet(tweet.id!)
            tweet.retweetCount++
            tweet.retweeted = true
            print("\(tweet.id!)")
        }
        retweetCount.text = "\(tweet.retweetCount)"
    }
    
    @IBAction func favoriteButtonClicked(sender: AnyObject) {
        if (tweet.favorited!) {
            TwitterClient.sharedInstance.destroyFavorite(tweet.id!)
            print("current fav count is \(currentFavoriteCount)")
            tweet.favoritesCount = currentFavoriteCount
            tweet.favorited = false
        } else {
            TwitterClient.sharedInstance.createFavorite(tweet.id!)
            print("current fav count is \(currentFavoriteCount)")
            tweet.favoritesCount = currentFavoriteCount
            tweet.favoritesCount++
            tweet.favorited = true
        }
        favoritesCount.text = "\(tweet.favoritesCount)"
    }
}
