//
//  LoginViewController.swift
//  Twitter
//
//  Created by Neal Patel on 2/20/16.
//  Copyright © 2016 Neal Patel. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLoginButton(sender: AnyObject) {
        print("login button pressed!")
        TwitterClient.sharedInstance.login({ () -> () in
            print("I've logged in!")
            self.performSegueWithIdentifier("loginSuccess", sender: nil)
        }) { (error: NSError) -> () in
            print("login error")
            print("error: \(error.localizedDescription)")
        }
    }
}