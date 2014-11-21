//
//  Question.swift
//  A+
//
//  Created by Simin on 11/19/14.
//  Copyright (c) 2014 Simin. All rights reserved.
//

import UIKit
var myQ:Question = Question()

struct task{
    var body = "empty question"
    var answer = ""
}
struct quest{
    var InitBody="Init Question"
    var inputUpper:[Double]=[]
    var inputLower:[Double]=[]
    var expression:String=""
}

class Question:NSObject{
    var QList = [task]()
    var InputList = [quest]()
    func addQuestion(InitBody:String,upper:[Double],lower:[Double],expression:String){
        InputList.append(quest(InitBody: InitBody, inputUpper: upper, inputLower: lower, expression: expression))
    }
    
    
    func calculate(num:[Double],operators:[String])->Double{
        var result:Double = 0.0
        result = num[0]
        for var i = 0; i<operators.count;++i{
            if(operators[i]=="+"){
                result+=num[i+1]
            }
            else if(operators[i]=="-"){
                result-=num[i+1]
            }
            else if(operators[i]=="*"){
                result*=num[i+1]
            }
            else if(operators[i]=="/"){
                result/=num[i+1]
            }
        }
        return result
    }

    
    func parseExp(express_string:String)->Double{
        var input = Array(express_string.unicodeScalars)
        var len = input.count
        var num:[Double]=[]
        var operators:[String]=[]
        var count:Int = 0
        var result:Double
        while(count<len){
            if(input[count].value >= 48 && input[count].value <= 57){
                var number:Double=0
                while(count<len && input[count].value >= 48 && input[count].value <= 57){
                    number = (10*number+Double((input[count].value-48)))
                    count++
                }
                num.append(number)
            }
            if(count==len){
              break
            }
            if(input[count]=="+"||input[count]=="-"||input[count]=="*"||input[count]=="/"){
                operators.append(String(input[count]))
            }
            count++
        }
        result = calculate(num, operators: operators)
        return result;
    }
    
    func updatePos(input:String)->String{
        var result = Array(input)
        var newInput:String=input
        var sign:Bool = true
        var i = 1
        if(result[0]=="-"){
            newInput = "0"+newInput
        }
        var len = result.count
        while(i<len-1){
            var temp = result[i]
            if(temp=="+"&&result[i+1]=="-"){
                newInput = newInput.substringToIndex(advance(newInput.startIndex, i))+newInput.substringFromIndex(advance(newInput.startIndex, i+1))
                i++
            }
            else if(temp=="-"&&result[i+1]=="-"){
                newInput = newInput.substringToIndex(advance(newInput.startIndex, i))+"+"+newInput.substringFromIndex(advance(newInput.startIndex, i+2))
                i++
            }
            else if ((temp=="*"||temp=="/")&&result[i+1]=="-"){
                sign = !sign
                newInput = newInput.substringToIndex(advance(newInput.startIndex, i+1))+newInput.substringFromIndex(advance(newInput.startIndex, i+2))
                i++
            }
            i++
            len = countElements(newInput)
        }
        if(sign==false){
            newInput = "0-"+newInput
        }
        return newInput
    }

    func validExp(input:String)->String{
        var result = Array(input.unicodeScalars )
        var len = result.count
        var newInput:String = input
        var i = 0
        while(i<len){
            if(result[i]=="*"||result[i]=="/"){
                var start = i-1
                while(start>=0 && result[start].value>=48 && result[start].value<=57){
                    start--
                }
                var newStart = newInput.substringToIndex(advance(newInput.startIndex, start+1))
                while(i<len){
                    if((result[i]=="*"||result[i]=="/")&&result[i+1]=="-"){
                        i++
                    }
                    else if(result[i]=="-"||result[i]=="+"){
                        break
                    }
                    i++
                }
                var newEnd = newInput.substringFromIndex(advance(newInput.startIndex, i))
                var remain = len-i-1
                var sub = newInput.substringToIndex(advance(newInput.startIndex, i))
                sub = sub.substringFromIndex(advance(sub.startIndex, start+1))
                sub = updatePos(sub)
                newInput = newStart+String(Int(parseExp(sub)))+newEnd
                len = countElements(newInput)
                result = Array(newInput.unicodeScalars)
                i = len - remain-1
                continue
            }
            i++
        }
        newInput = updatePos(newInput)
        var tempRe = Int(parseExp(newInput))
        return String(tempRe)
    }
    
    func degradeExp(input:String)->String{
        var result=Array(input)
        var num_front = 0
        var num_end = 0
        var i = 0
        var len = countElements(input)
        var start = 0
        var myEnd:String=""
        while(result[i] != "(" && i != (len-1)){
            i++
        }
        start = i+1
        num_front++;
        if(i == (len-1))
        {
            return validExp(input)
        }
        var myStart = input.substringToIndex(advance(input.startIndex,i))
        println("myStart  \(myStart)")
        i++
        
        while(i < len){
            if(result[i]=="("){
                num_front++;
            }
            if(result[i]==")"){
                num_end++;
                if(num_front==num_end){
                    myEnd = input.substringFromIndex(advance(input.startIndex,i+1))
                    println("myEnd   \(myEnd)")
                    break
                }
            }
            i++
        }
        var recurse = input.substringToIndex(advance(input.startIndex,i))
        recurse = recurse.substringFromIndex(advance(recurse.startIndex,start))
        
        println("recurse  \(recurse)")
        var temp:String = myStart+degradeExp(recurse)+myEnd
        temp = degradeExp(temp)
        return temp
    
    }

    func generate(){
        for eachQ in InputList{
            var variables:[Int] = generateInput(eachQ)
            var questionBody = generateBody(variables,Init:eachQ.InitBody)
            var myAnswer = generateAnswer(eachQ.expression,vari: variables)
            QList.append(task(body: questionBody, answer: myAnswer))
            InputList = [quest]()
        }
        for ans in QList{
            println("Answer sheet\(ans.answer)")
        }
    }
    
    func generateInput(myQuest:quest)->[Int]{
        var result:[Int]=[]
        for var index = 0;index < myQuest.inputUpper.count;++index{
            var temp = Double(arc4random())
            
            var upp:Double = myQuest.inputUpper[index]
            var low:Double = myQuest.inputLower[index]
            temp = temp%((upp-low))+low
            println("generateInput\(temp)")
            result.append(Int(temp))
            
        }
        return result
    }
    
    func generateBody(vari:[Int],Init:String)->String{
        var result = NSString(string: Init)
        for var i=0; i < vari.count; ++i{
            var goal:String = "$\(i+1)"
            println(goal)
            var sub:String = String(vari[i])
            println(sub)
            result = result.stringByReplacingOccurrencesOfString(goal,withString:sub)
            println(result)
        }
        return result
        
    }
    
    func generateAnswer(expression:String,vari:[Int])->String{
        var result = NSString(string: expression)
        for var i=0; i < vari.count; ++i{
            var goal:String = "$\(i+1)"
            println(goal)
            var sub:String = String(vari[i])
            println(sub)
            result = result.stringByReplacingOccurrencesOfString(goal,withString:sub)
            println(result)
        }
        result = degradeExp(result)
        println(result)
        
        return result
    }
    
 
    

    
    
    
}