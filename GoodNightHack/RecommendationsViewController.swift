//
//  RecommendationsViewController.swift
//  GoodNightHack
//
//  Created by Michael Schinis on 08/11/2014.
//  Copyright (c) 2014 Mistirio. All rights reserved.
//

import UIKit
import Parse

class RecommendationsViewController: UIViewController, PFLogInViewControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    var dbResults:[PFObject] = []
    var recommendationUnits:[Int] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PFUser.logOut()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        if( PFUser.currentUser() == nil){
            var loginViewController = MyLoginViewController()
            loginViewController.delegate = self
            loginViewController.fields = PFLogInFields.Facebook
            loginViewController.facebookPermissions = ["public_profile","email"]
            self.presentViewController(loginViewController, animated: true, completion: nil)
        }else{
            println(PFUser.currentUser().objectId)
            
            PFCloud.callFunctionInBackground("getSuggestions", withParameters: ["userId" : PFUser.currentUser().objectId]) {
                ( response : AnyObject!,  error : NSError!) -> Void in
                if error == nil {
                    println(response)
                    if response.count != nil {
                        self.dbResults.removeAll(keepCapacity: true)
                        self.recommendationUnits.removeAll(keepCapacity: true)
                        println("\(self.dbResults) & \(self.recommendationUnits)")
                        self.tableView.reloadData()
                        for item in response as NSDictionary {
                            println("\(item.value as Int)")
                            self.recommendationUnits.append(item.value as Int)
                            
                            var query = PFQuery(className: "Drink")
                            query.whereKey("objectId", equalTo: item.0)
                            query.findObjectsInBackgroundWithBlock({
                                (res: [AnyObject]!, err: NSError!) -> Void in
                                self.dbResults += res as [PFObject]
                                self.tableView.reloadData()
                            })
                        }

                    }
                }
            }
        }
        
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("RecommendationItemCell") as UITableViewCell
        let potiri = self.dbResults[indexPath.row]["size"] as? String
        cell.textLabel.text = self.dbResults[indexPath.row]["name"] as? String
        
        cell.detailTextLabel?.text = "Up to \(self.recommendationUnits[indexPath.row]) " + potiri! + " "
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dbResults.count
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
        logoLabel.text = "Alcommend"
        logoLabel.font = UIFont(name: "AmericanTypewriter", size: 40)
        logoLabel.sizeToFit()
        self.logInView.logo = logoLabel as UIView
    }
}
