//
//  SecondViewController.swift
//  A+
//
//  Created by Simin on 11/19/14.
//  Copyright (c) 2014 Simin. All rights reserved.
//

import UIKit
var questionIndex = 0

class SecondViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        NextOne.hidden=true
        Right_Wrong.hidden=true
        //myQ.generate()
        if(myQ.QList.count==questionIndex){
            QuestionBody.text = "We now do not have any question for you"
            Submit.hidden=true
        }
        else{
            QuestionBody.text=myQ.QList[questionIndex].body
            Submit.hidden=false
        }
        QuestionBody.hidden=false
    }
    //refresh page before visible
    override func viewWillAppear(animated: Bool){
        myQ.generate()
        if(questionIndex==0){
            prev.hidden = true
        }
        if(questionIndex != 0){
            prev.hidden = false
        }
        if(myQ.QList.count==questionIndex){
            QuestionBody.text = "We now do not have any question for you"
            Submit.hidden=true
        }
        else{
            QuestionBody.text=myQ.QList[questionIndex].body
            Submit.hidden=false
        }
        QuestionBody.hidden=false
        Right_Wrong.hidden=true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet var QuestionBody: UITextView!

    @IBOutlet var Right_Wrong: UITextView!
    @IBOutlet var UserInput: UITextField!
    @IBOutlet var Submit: UIButton!
    @IBOutlet var prev: UIButton!
    
    @IBOutlet var NextOne: UIButton!

    @IBAction func Click_prev(sender: AnyObject) {
        questionIndex--
        if(questionIndex<0){
            QuestionBody.text = "This is the head of question list"
            Right_Wrong.hidden = true
            prev.hidden = true
            NextOne.hidden = false
            return
        }
        QuestionBody.text = myQ.QList[questionIndex].body
        NextOne.hidden = false
        Right_Wrong.hidden = true
    }
    
    @IBAction func Click_Submit(sender: AnyObject) {
        prev.hidden = false
        if(UserInput.text == myQ.QList[questionIndex].answer){
            Right_Wrong.text="Right!"
            NextOne.hidden = false
        }
        else{Right_Wrong.text="Think a litter harder"}
        Right_Wrong.hidden = false
        UserInput.text = ""
    }
    
    @IBAction func Click_NextOne(sender: AnyObject) {
        questionIndex++
        if(questionIndex>=myQ.QList.count){
            QuestionBody.text="You finished all the questions!"
        }
        else {
            QuestionBody.text = myQ.QList[questionIndex].body
        }
        NextOne.hidden = true
        Right_Wrong.hidden = true
        
    }
    
    //TextField helper condition
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder();
        return true;
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
}

