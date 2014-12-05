//
//  GradeBookViewController.swift
//  A+
//
//  Created by Simin on 12/4/14.
//  Copyright (c) 2014 Simin. All rights reserved.
//

import UIKit

class GradeBookViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        Report.hidden = true
        // Do view setup here.
    }
    @IBAction func OnClickUpdate(sender: AnyObject) {
        Report.hidden = false
        if((secondView.getIndex()==0)||(myQ.QList.count==0)){
             Progress.setProgress(0.0, animated: true)
             Report.text = "No question listed or answered"
             return
        }
        var complete = (Float(secondView.getIndex()))/(Float(myQ.QList.count))
        Progress.setProgress(complete, animated: true)
        if(complete == 1){
            Report.text = "Congratulation! You have finished all questions!"
        }
        else{
            Report.text = "You have finished \(100*complete) percent of the questions!"
        }
        
    }
    @IBOutlet var Progress: UIProgressView!
    
    @IBOutlet var Report: UITextView!
    
    
}
