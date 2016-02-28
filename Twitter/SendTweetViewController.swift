//
//  SendTweetViewController.swift
//  Twitter
//
//  Created by Neal Patel on 2/28/16.
//  Copyright © 2016 Neal Patel. All rights reserved.
//

import UIKit

class SendTweetViewController: UIViewController {

    @IBOutlet weak var tweetTextField: UITextField!
    @IBOutlet weak var charCount: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tweetTextField.becomeFirstResponder()
        tweetTextField.text = tweetText
        tweetTextView.text = tweetTextField.text
        charCount.text = "\(140 - tweetTextView.text.characters.count)"
    }
    
    @IBAction func textLimit(sender: AnyObject) {
        tweetTextView.text = tweetTextField.text
        tweetTextField.text = tweetTextView.text
        charCount.text = "\(140 - tweetTextField.text!.characters.count)"
        if charCount.text == "0" {
            errorAlert("Error", messageSample: "You may not go over the limit.")
        }
        if tweetTextView.text.characters.count == tweetTextView.text.characters.count + 1 {
            charCount.text = "\((Int(charCount.text!))! - 1)"
        } else {
            charCount.text = "\(Int(charCount.text!)! + 1)"
        }
    }
    
    func errorAlert(let titleSample : String, let messageSample : String) {
        
        let alertController = UIAlertController(title: titleSample, message: messageSample, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            
        }
        
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
        }
    }

    @IBAction func sendButton(sender: AnyObject) {
        if tweetTextField.text?.characters.count > 140 || tweetTextField.text?.characters.count == 0 || tweetTextView.text?.characters.count > 140 || tweetTextView.text?.characters.count == 0 {
            errorAlert("Error", messageSample: "You have either typed too much or nothing at all.")
        } else {
            TwitterClient.sharedInstance.tweet(tweetTextField.text!)
            navigationController?.popToRootViewControllerAnimated(true)
        }
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
