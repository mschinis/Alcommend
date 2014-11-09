//
//  dayDrinksViewController.swift
//  GoodNightHack
//
//  Created by Michael Schinis on 09/11/2014.
//  Copyright (c) 2014 Mistirio. All rights reserved.
//

import UIKit

class DayDrinksViewController: UIViewController {

    @IBOutlet weak var feelingLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var mainVC:HistoryViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedRow = mainVC.tableView.cellForRowAtIndexPath(mainVC.tableView.indexPathForSelectedRow()!) as HistoryItemTableViewCell
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
