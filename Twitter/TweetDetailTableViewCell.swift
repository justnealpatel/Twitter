//
//  TweetDetailTableViewCell.swift
//  Twitter
//
//  Created by Neal Patel on 2/27/16.
//  Copyright © 2016 Neal Patel. All rights reserved.
//

import UIKit
import AFNetworking

class TweetDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var tweetView: UITextView!
    @IBOutlet weak var twittername: UILabel!
    @IBOutlet weak var twitterHandle: UILabel!
    @IBOutlet weak var tweetField: UILabel!
    @IBOutlet weak var tweetDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
