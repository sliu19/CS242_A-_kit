//
//  FirstViewController.swift
//  A+
//
//  Created by Simin on 11/19/14.
//  Copyright (c) 2014 Simin. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet var Question: UITextField!
    
    @IBOutlet var Answer: UITextField!
    @IBOutlet var var1_U: UITextField!
    @IBOutlet var var1_L: UITextField!
    @IBOutlet var var2_U: UITextField!
    @IBOutlet var var2_L: UITextField!
    @IBOutlet var var3_U: UITextField!
    @IBOutlet var var3_L: UITextField!
    @IBOutlet var var4_U: UITextField!
    @IBOutlet var var4_L: UITextField!
    
    
    @IBAction func Click_Add(sender: AnyObject) {
        var upper:[Double]=[]
        var lower:[Double]=[]
        if(var1_L.text != ""){
            var tempU = NSString(string: var1_U.text)
            upper.append(tempU.doubleValue)
            var tempL = NSString(string: var1_L.text)
            lower.append(tempL.doubleValue)
        }
        if(var2_L.text != ""){
            var tempU = NSString(string: var2_U.text)
            upper.append(tempU.doubleValue)
            var tempL = NSString(string: var2_L.text)
            lower.append(tempL.doubleValue)
        }
        if(var3_L.text != ""){
            var tempU = NSString(string: var3_U.text)
            upper.append(tempU.doubleValue)
            var tempL = NSString(string: var3_L.text)
            lower.append(tempL.doubleValue)
        }
        if(var4_L.text != ""){
            var tempU = NSString(string: var4_U.text)
            upper.append(tempU.doubleValue)
            var tempL = NSString(string: var4_L.text)
            lower.append(tempL.doubleValue)
        }
        
        myQ.addQuestion(Question.text,upper: upper,lower: lower,expression: Answer.text)
        Question.text=""
        Answer.text=""
        var1_L.text=""
        var1_U.text=""
        var2_L.text=""
        var2_U.text=""
        var3_L.text=""
        var3_U.text=""
        var4_L.text=""
        var4_U.text=""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
}

