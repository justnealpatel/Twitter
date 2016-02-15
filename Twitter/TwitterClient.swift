//
//  TwitterClient.swift
//  Twitter
//
//  Created by Neal Patel on 2/14/16.
//  Copyright © 2016 Neal Patel. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterBaseURL = NSURL(string: "https://api.twitter.com")
let twitterConsumerKey = "BHf9k1YH9RvQDPRgNv9fFulJl"
let twitterConsumerSecret = "xWc15bRrjM4S6Kp4rBaX0Ivj0qD8fgNdPq4HO40EuGaBM9id3X"

class TwitterClient: BDBOAuth1SessionManager {
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
}
