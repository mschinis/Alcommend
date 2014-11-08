//
//  MainViewController.swift
//  GoodNightHack
//
//  Created by Michael Schinis on 08/11/2014.
//  Copyright (c) 2014 Mistirio. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RecommendationsButtonPressed(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    @IBAction func HistoryButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("showPreviousViewSegue", sender: self)
    }
    
    @IBAction func AddDrinksButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("showDrinksSegue", sender: self)
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
