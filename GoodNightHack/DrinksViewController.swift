//
//  DrinksViewController.swift
//  GoodNightHack
//
//  Created by Michael Schinis on 08/11/2014.
//  Copyright (c) 2014 Mistirio. All rights reserved.
//

import UIKit
import Parse

class DrinksViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate, UIAlertViewDelegate {

    var selectedDrinks:[PFObject] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var feelingPicker: UIPickerView!
    @IBOutlet weak var feelingView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feelingPicker.dataSource = self
        self.feelingPicker.delegate = self
        
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func MenuBarButtonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("drinkCell") as UITableViewCell
        
        cell.textLabel.text = selectedDrinks[indexPath.row]["name"] as? String
        cell.detailTextLabel?.text = selectedDrinks[indexPath.row]["size"] as? String
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedDrinks.count
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addDrinkItemSegue" {
            var destinationController:AddDrinkViewController = segue.destinationViewController as AddDrinkViewController
            destinationController.mainVC = self
        }
    }
    
    @IBAction func continueBarButtonPressed(sender: UIBarButtonItem) {
        if selectedDrinks.count == 0 {
            let warningView = Helper().alert("Warning", bodyString: "Please choose the drinks you have had")
            self.presentViewController(warningView, animated: true, completion: nil)
        }else{
            showFeelingView()
        }
        
    }
    @IBAction func cancelFeelingButtonPressed(sender: UIButton) {
        hideFeelingView()
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        switch(row){
        case 0:
            return "Perfect"
        case 1:
            return "Tipsy"
        case 2:
            return "One too many"
        case 3:
            return "Drunk"
        case 4:
            return "Puked"
        default:
            return "whateva"
        }
    }
    @IBAction func feelingButtonPressed(sender: UIButton) {
        let feelingValue = self.feelingPicker.selectedRowInComponent(0)
        var totalUnits:Float = 0.0
        var totalCalories = 0
        
        for item in selectedDrinks{
            totalCalories += item["calorie"] as Int
            totalUnits += item["unitPerServing"] as Float
        }
        
        var dayGroup = PFObject(className: "DrinkGroup")
        dayGroup["feeling"] = feelingValue
        dayGroup["units"] = totalUnits
        dayGroup["calories"] =  totalCalories
        dayGroup["userId"] = PFObject(withoutDataWithClassName: "_User", objectId: PFUser.currentUser().objectId)
        dayGroup.saveInBackgroundWithBlock {
            (res: Bool, err:NSError!) -> Void in
            if(err == nil && res == true){
                let newInsertObjectId = dayGroup.objectId
                self.storeDrinkRecords(newInsertObjectId)
            }else{
                var alertView = Helper().alert("Warning", bodyString: "Could not upload your information to the cloud")
                self.presentViewController(alertView, animated: true, completion: nil)
            }
        }
    }
    func storeDrinkRecords(objectId: String){
        var storeArray:[PFObject] = []
        
        for item in selectedDrinks {
            var record = PFObject(className: "DrinkRecord")
            record["drinkId"] = PFObject(withoutDataWithClassName: "Drink", objectId: item.objectId)
            record["groupId"] = PFObject(withoutDataWithClassName: "DrinkGroup", objectId: objectId)
            storeArray.append(record)
        }
        
        PFObject.saveAllInBackground(storeArray, block: {
            (success: Bool, error: NSError!) -> Void in
            if success == true && error == nil {
                let thisNavigationController = self.navigationController;
                
                var alertView = UIAlertController(title: "Success", message: "Stored Successfully", preferredStyle: UIAlertControllerStyle.Alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
                    (action) -> Void in
                    self.selectedDrinks.removeAll(keepCapacity: false)
                    self.tableView.reloadData()
                    self.hideFeelingView()
                })
                alertView.addAction(okButton)
                self.presentViewController(alertView, animated: true, completion: nil)
                
            }
        })
            
    }
    func hideFeelingView(){
        UIView.animateWithDuration(0.5, animations: {
            self.feelingView.alpha = 0
        })
    }
    func showFeelingView(){
        UIView.animateWithDuration(0.5, animations: {
            self.feelingView.alpha = 1
        })
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
