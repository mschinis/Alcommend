//
//  AddDrinkViewController.swift
//  GoodNightHack
//
//  Created by Michael Schinis on 08/11/2014.
//  Copyright (c) 2014 Mistirio. All rights reserved.
//

import UIKit
import Parse

class AddDrinkViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var mainVC:DrinksViewController!
    
    var drinks:[PFObject] = []
    var drinksCopy:[PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        
        var searchQuery = PFQuery(className: "Drink")
        searchQuery.findObjectsInBackgroundWithBlock {
            (res:[AnyObject]!, err:NSError!) -> Void in
            if(err == nil){
                self.drinks = res as [PFObject]
                self.drinksCopy = res as [PFObject]
                
                self.tableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("drinkCell") as AddDrinkItemTableViewCell
        cell.titleLabel.text = self.drinks[indexPath.row]["name"] as? String
        cell.detailLabel.text = self.drinks[indexPath.row]["size"] as? String
        cell.item = self.drinks[indexPath.row]
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.drinks.count
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty == true){
            drinks = drinksCopy
            tableView.reloadData()
        }else{
            filterContentForSearchText(searchText)
            tableView.reloadData()
        }
    }
    
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        self.drinks = self.drinksCopy.filter({( object: PFObject) -> Bool in
            let stringMatch = (object["name"] as String).lowercaseString.rangeOfString(searchText.lowercaseString)
            return (stringMatch != nil)
        })
    }
    @IBAction func addBarButtonPressed(sender: UIBarButtonItem) {
        let selectedRow = self.tableView.indexPathForSelectedRow();
        
        let cell = self.tableView.cellForRowAtIndexPath(selectedRow!) as AddDrinkItemTableViewCell
        
        self.mainVC.selectedDrinks.append(cell.item)
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
