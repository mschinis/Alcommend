//
//  dayDrinksViewController.swift
//  GoodNightHack
//
//  Created by Michael Schinis on 09/11/2014.
//  Copyright (c) 2014 Mistirio. All rights reserved.
//

import UIKit

class DayDrinksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var feelingLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    var mainVC:HistoryViewController!
    var dbResultss:[PFObject] = []
    var dbResults:[PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let selectedRow = mainVC.tableView.cellForRowAtIndexPath(mainVC.tableView.indexPathForSelectedRow()!) as HistoryItemTableViewCell
        
        var query = PFQuery(className: "DrinkRecord")
        query.whereKey("groupId",
            equalTo: PFObject(withoutDataWithClassName: "DrinkGroup",
                objectId: selectedRow.item.objectId))
        println(selectedRow.item.objectId)
        
        query.findObjectsInBackgroundWithBlock {
            (results: [AnyObject]!, error:NSError!) -> Void in
            if(error == nil){
                self.dbResultss = results as [PFObject]
                
                for result in self.dbResultss as [PFObject] {
                    var secondQ = PFQuery(className: "Drink")
                    //secondQ.whereKey("objectId", equalTo: PFObject(withoutDataWithClassName: "DrinkRecord", objectId: result["drinkId"] as String))
                    
                    secondQ.findObjectsInBackgroundWithBlock(
                        { (res: [AnyObject]!, err: NSError!) -> Void in
                        self.dbResults += res as [PFObject]
                        self.tableView.reloadData()
                    })
                }
                
            }
        }
        
        self.feelingLabel.text = selectedRow.feelingLabel.text
        self.unitsLabel.text = selectedRow.unitsLabel.text
        self.caloriesLabel.text = selectedRow.caloriesLabel.text
        self.dateLabel.text = selectedRow.dateLabel.text
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeBarButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dbResults.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("dayOverviewItemCell") as UITableViewCell
        
        cell.textLabel.text = self.dbResults[indexPath.row]["name"] as? String
        cell.detailTextLabel?.text = self.dbResults[indexPath.row]["Type"] as? String
        return cell
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
