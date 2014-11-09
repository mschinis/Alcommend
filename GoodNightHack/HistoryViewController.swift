//
//  PreviousViewController.swift
//  GoodNightHack
//
//  Created by Michael Schinis on 08/11/2014.
//  Copyright (c) 2014 Mistirio. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let dateFormatter = NSDateFormatter()
    var dbResults:[PFObject] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        self.dateFormatter.dateFormat = "dd/MM/yyyy"
        
        var query = PFQuery(className: "DrinkGroup")
        query.whereKey("userId", equalTo: PFObject(withoutDataWithClassName: "_User", objectId: PFUser.currentUser().objectId))
        query.findObjectsInBackgroundWithBlock {
            (results: [AnyObject]!, error:NSError!) -> Void in
            if(error == nil){
                self.dbResults = results as [PFObject]
                println(self.dbResults)
                self.tableView.reloadData()
            }
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("HistoryItemCell") as HistoryItemTableViewCell
        let caloriesNumber = dbResults[indexPath.row]["calories"] as Int
        let unitsNumber = dbResults[indexPath.row]["units"] as Float
        let feeling = dbResults[indexPath.row]["feeling"] as Int
        
        cell.dateLabel.text = self.dateFormatter.stringFromDate(dbResults[indexPath.row].createdAt as NSDate)
        
        cell.caloriesLabel.text = "\(caloriesNumber) Calories"
        cell.unitsLabel.text = "\(unitsNumber) Units"
        cell.feelingLabel.text = "\(Helper().getFeelingatIndex(feeling))"
        cell.item = dbResults[indexPath.row]
        
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dbResults.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showDayDrinksSegue", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func MenuBarButtonPressed(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showDayDrinksSegue"){
            let destinationController = segue.destinationViewController as DayDrinksViewController
            destinationController.mainVC = self
        }
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
