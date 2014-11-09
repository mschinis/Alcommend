//
//  Helper.swift
//  GoodNightHack
//
//  Created by Michael Schinis on 08/11/2014.
//  Copyright (c) 2014 Mistirio. All rights reserved.
//

import Foundation

struct Helper{
    var user:PFUser = PFUser()
    var feelings = ["Perfect","Tipsy","One too many","Drunk","Puked"]
    
    func alert(titleString:String,bodyString:String) -> UIAlertController{
        var alertView = UIAlertController(title: titleString, message: bodyString, preferredStyle: UIAlertControllerStyle.Alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alertView.addAction(okButton)
        return alertView
    }
    func getFeelingatIndex(index:Int) -> String{
        return self.feelings[index]
    }
    
}