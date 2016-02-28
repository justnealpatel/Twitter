//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Neal Patel on 2/27/16.
//  Copyright © 2016 Neal Patel. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tweetDetailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tweetDetailTableView.dataSource = self
        tweetDetailTableView.delegate = self
        let image : UIImage = UIImage(named: "TwitterTest.png")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell1 = UITableViewCell()
        if indexPath.row == 0 {
            let cell = tweetDetailTableView.dequeueReusableCellWithIdentifier("tweet", forIndexPath: indexPath) as! TweetDetailTableViewCell
            let currentName = "\(((dictionary["user"]!)["name"]!)!)"
            let userName = "@\(((dictionary["user"]!)["screen_name"]!)!)"
            let profileURL = "\(((dictionary["user"]!)["profile_image_url_https"]!)!)"
            print("profile url is \(profileURL)")
            let formatter = NSDateFormatter()
            formatter.dateFormat = "M/d/yy h:m a"
            let shortDate = formatter.stringFromDate(date!)
            let tweetView = dictionary["text"] as? String
            cell.profilePicImageView.setImageWithURL(NSURL(string: profileURL)!)
            cell.profilePicImageView.contentMode = .ScaleAspectFit
            cell.twittername.text = currentName
            cell.twitterHandle.text = userName
            cell.tweetField.text = tweetView
            cell.tweetField.numberOfLines = 0
            cell.tweetDate.text = shortDate
            cell1 = cell
            return cell
        } else if indexPath.row == 1 {
            let cell = tweetDetailTableView.dequeueReusableCellWithIdentifier("counter", forIndexPath: indexPath) as! TweetCountTableViewCell
            cell.retweetLabel.text = "\(retweet)"
            cell.likesLabel.text = "\(likes)"
            print("\(cell.retweetLabel.text)")
            print("\(cell.likesLabel.text)")
            if retweet == 1 {
                cell.retweetText.text = "RETWEET"
            }
            if likes == 1 {
                cell.likesText.text = "LIKE"
            }
            cell1 = cell
        } 
        return cell1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
