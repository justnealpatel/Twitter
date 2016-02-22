//
//  TwitterClient.swift
//  Twitter
//
//  Created by Neal Patel on 2/20/16.
//  Copyright © 2016 Neal Patel. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "BHf9k1YH9RvQDPRgNv9fFulJl", consumerSecret: "xWc15bRrjM4S6Kp4rBaX0Ivj0qD8fgNdPq4HO40EuGaBM9id3X")
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            print("home timeline")
                success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            print("home timeline error!")
                failure(error)
        })
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! NSDictionary
            print("current account")
            let user = User(dictionary: userDictionary)
            print("currentaccount!")
            success(user)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                // Code
                print("you have failed this city")
                failure(error)
        })
    }
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        print("login time")
        loginSuccess = success
        loginFailure = failure
        deauthorize()
        print("deauthorize has happened")
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            // Code
            print("I got a token!")
            print(requestToken.token)
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            print(url)
            UIApplication.sharedApplication().openURL(url)
            }) { (error: NSError!) -> Void in
                // Code
                print("login ERROR!")
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
//    func logout() {
//        User.currentUser = nil
//        deauthorize()
//        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
//    }
    
    func retweet(id: String) {
        POST("1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("Retweet")
            },
            failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Error retweeting")
            }
        )
    }
    
    func unretweet(id: String) {
        POST("1.1/statuses/unretweet/\(id).json", parameters: nil, progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("Unretweet")
            },
            failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Error unretweeting")
            }
        )
    }
    
    func createFavorite(id: String) {
        POST("1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("Create a favorite")
            },
            failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Error creating a favorite")
            }
        )
    }
    
    func destroyFavorite(id: String) {
        POST("1.1/favorites/destroy.json?id=\(id)", parameters: nil, progress: nil,
            success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("Destroy a favorite")
            },
            failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Error destroying a favorite")
            }
        )
    }
    
    func handleOpenURL(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            // Code
            print("I got the access token!")
            self.currentAccount({ (user: User) -> () in
                print("entering")
//                User.currentUser = user
                print("success!")
                self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    print("handleopenurl error!")
                    self.loginFailure?(error)
            })
            }) { (error: NSError!) -> Void in
                // Code
                print("error: \(error.localizedDescription)")
                print("handleopenurl error!")
                self.loginFailure?(error)
        }
    }
}
