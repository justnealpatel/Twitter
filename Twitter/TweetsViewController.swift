//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Neal Patel on 2/20/16.
//  Copyright © 2016 Neal Patel. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tweetTableView: UITableView!
    var retweetCount = 0
    var tweet: Tweet?
    var rowNumber = 0
    var tweets: [Tweet]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let image : UIImage = UIImage(named: "TwitterTest.png")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
        self.tweetTableView.dataSource = self
        self.tweetTableView.delegate = self
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tweetTableView.reloadData()
//            for tweet in tweets {
//                print(tweet.text)
//            }
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("cellForRowAtIndexPath called")
        let cell = tweetTableView.dequeueReusableCellWithIdentifier("tweetcell", forIndexPath: indexPath) as! TweetTableViewCell
        cell.tweet = tweets![indexPath.row]
//        let tweet = tweets![indexPath.row]
//        rowNumber = indexPath.row
//        print("retweetCount:\(retweetCount)")
//        let dictionary: NSDictionary = tweet.currentDictionary
//        cell.tweetContentTextView.text = tweet.text as? String
//        if retweetCount != 0{
//            cell.retweetCount.text = "\(retweetCount)"
//        } else {
//            cell.retweetCount.text = "\(tweet.retweetCount)"
//        }
//        print(cell.retweetCount.text!)
//        retweetCount = NSNumberFormatter().numberFromString(cell.retweetCount.text!) as! Int
////        print(retweetCount)
//        let favorites = "\(((dictionary["user"]!)["favourites_count"]!)!)"
//        cell.favoritesCount.text = favorites
//        let profileURL = "\(((dictionary["user"]!)["profile_image_url_https"]!)!)"
//        let URL = NSURL(string: profileURL)!
//        cell.datePostedTextField.text = convertTimeToString(Int(NSDate().timeIntervalSinceDate(tweet.timeStamp!)))
//        cell.profileImageView.setImageWithURL(URL)
//        cell.profileImageView.contentMode = .ScaleAspectFit
//        let twitterHandle = "@\(((dictionary["user"]!)["screen_name"]!)!)"
//        cell.usernameLabel.text = twitterHandle
//        cell.twitterNameLabel.text = "\(((dictionary["user"]!)["name"]!)!)"
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
}