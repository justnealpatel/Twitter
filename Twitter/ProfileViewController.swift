//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Neal Patel on 2/28/16.
//  Copyright © 2016 Neal Patel. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    @IBOutlet weak var tweets: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var profileBanner: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = "\(((dictionary["user"]!)["name"]!)!)"
        twitterHandleLabel.text = "@\(((dictionary["user"]!)["name"]!)!)"
        let pbURL = "\(((dictionary["user"]!)["profile_banner_url"]!)!)"
        profileBanner.setImageWithURL(NSURL(string: pbURL)!)
        profileBanner.contentMode = .ScaleToFill
        let profileURL = "\(((dictionary["user"]!)["profile_image_url_https"]!)!)"
        profileImage.setImageWithURL(NSURL(string: profileURL)!)
        tweets.text = "\(((dictionary["user"]!)["statuses_count"]!)!)"
        following.text = "\(((dictionary["user"]!)["friends_count"]!)!)"
        followers.text = "\(((dictionary["user"]!)["followers_count"]!)!)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
