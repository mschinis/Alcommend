//
//  RecommendationsViewController.swift
//  GoodNightHack
//
//  Created by Michael Schinis on 08/11/2014.
//  Copyright (c) 2014 Mistirio. All rights reserved.
//

import UIKit
import Parse

class RecommendationsViewController: UIViewController, PFLogInViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        
        if( PFUser.currentUser() == nil){
            var loginViewController = MyLoginViewController()
            loginViewController.delegate = self
            loginViewController.fields = PFLogInFields.Facebook
            loginViewController.facebookPermissions = ["public_profile","email"]
            self.presentViewController(loginViewController, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMenuBarButtonPressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier("showMenuSegue", sender: self)
    }
    func logInViewController(logInController: PFLogInViewController!, didLogInUser user: PFUser!) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func logInViewController(logInController: PFLogInViewController!, didFailToLogInWithError error: NSError!) {
        let alertView = Helper().alert("Warning", bodyString: "Something went wrong")
        self.presentViewController(alertView, animated: true, completion: nil)
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

class MyLoginViewController : PFLogInViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoLabel = UILabel()
        logoLabel.text = "Alcommend me"
        logoLabel.font = UIFont(name: "AmericanTypewriter", size: 40)
        logoLabel.sizeToFit()
        self.logInView.logo = logoLabel as UIView
    }
}
