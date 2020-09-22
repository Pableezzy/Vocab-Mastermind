//
//  StateManager.swift
//  QuizApp
//
//  Created by Pablo Zepeda on 9/5/20.
//  Copyright © 2020 Pablo Zepeda. All rights reserved.
//

import Foundation

class StateManager {
    
    static var numCorrectKey = "NumberCorrectKey"
    static var questionIndexKey = "QuestionIndexKey"

    //store two numbers into user defaults
    static func saveState(numCorrect:Int, questionIndex:Int){
        //get a reference to user defaults
        let defaults = UserDefaults.standard
        //save the state data
        defaults.set(numCorrect, forKey: numCorrectKey)
        defaults.set(questionIndex, forKey: questionIndexKey)
        
    }
    static func retrieveValue(key:String)->Any? {
        //get a reference to user defaults
        let defaults = UserDefaults.standard
        return defaults.value(forKey: key)
        
    }
    static func clearState(){
        //get a reference to user defaults
        let defaults = UserDefaults.standard
        //clear the state data in user defaults
        defaults.removeObject(forKey: numCorrectKey)
        defaults.removeObject(forKey: questionIndexKey)
    }
}
