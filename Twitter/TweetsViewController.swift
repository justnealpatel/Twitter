//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Neal Patel on 2/20/16.
//  Copyright © 2016 Neal Patel. All rights reserved.
//

import UIKit
import AFNetworking

var dictionary: NSDictionary = NSDictionary()


class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tweetTableView: UITableView!
    var retweetCount = 0
    var tweet: Tweet?
    var rowNumber = 0
    var tweets: [Tweet]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tweetTableView.rowHeight = UITableViewAutomaticDimension
        tweetTableView.estimatedRowHeight = 120
        let image : UIImage = UIImage(named: "TwitterTest.png")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
        self.tweetTableView.dataSource = self
        self.tweetTableView.delegate = self
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tweetTableView.reloadData()
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        print("You did it!")
        tweetTableView.backgroundColor = UIColor(white: 1, alpha: 1.0)
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = tweetTableView.cellForRowAtIndexPath(indexPath)! as! TweetTableViewCell
        dictionary = selectedCell.tweet.currentDictionary
        print("tweet date is \(selectedCell.tweet.timeStamp)")
        date = selectedCell.tweet.timeStamp
        retweet = selectedCell.tweet.retweetCount
        likes = selectedCell.tweet.favoritesCount
        thisTweet = selectedCell.tweet
        tweetText = "@\(((dictionary["user"]!)["screen_name"]!)!) "

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    @IBAction func tweetPressed(sender: AnyObject) {
        performSegueWithIdentifier("tweetClicked", sender: self)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        print("cellForRowAtIndexPath called")
        let cell = tweetTableView.dequeueReusableCellWithIdentifier("tweetcell", forIndexPath: indexPath) as! TweetTableViewCell
        cell.tweet = tweets![indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
//        TwitterClient.sharedInstance.logout()
    }
}