//
//  MainViewController.swift
//  GoodNightHack
//
//  Created by Michael Schinis on 08/11/2014.
//  Copyright (c) 2014 Mistirio. All rights reserved.
//

import UIKit
import QuartzCore

class MainViewController: UIViewController, LineChartDelegate {
    
//    @IBOutlet weak var chartView: UIView!
//    var lineChart: LineChart?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var data: Array<CGFloat> = [3, 4, 9, 11, 13, 15]
        var data2: Array<CGFloat> = [1, 3, 5, 13, 17, 20]
        
        
    
        // Do any additional setup after loading the view.
    }
    func didSelectDataPoint(x: CGFloat, yValues: Array<CGFloat>) {
        //label.text = "x: \(x)     y: \(yValues)"
    }
    
    override func viewWillAppear(animated: Bool){
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
