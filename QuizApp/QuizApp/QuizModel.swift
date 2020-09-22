//
//  QuizModel.swift
//  QuizApp
//
//  Created by Pablo Zepeda on 8/29/20.
//  Copyright © 2020 Pablo Zepeda. All rights reserved.
//

import Foundation

protocol QuizProtocol {
    func questionsRetrieved(_ questions:[Question])
}

class QuizModel{
    
    var delegate:QuizProtocol?
    
    func getQuestions(){
        // TODO: Fetch the questions
       // getLocalJsonFile()
       getRemoteJsonFile()
        
    }
    
    func getLocalJsonFile(){
        //get bundle path to json file
        let path = Bundle.main.path(forResource: "QuestionData", ofType: "json")
        
        //double check that the guard statement isn't nil
        guard path != nil else {
            print("Couldn't find the json data file")
            return
        }
        //create URL object from the path
       let url = URL(fileURLWithPath: path!)
        
        do {
        //get the data from the url
        let data = try Data(contentsOf: url)
            
        //try to decode the data into objects
        let decoder = JSONDecoder()
        let array = try decoder.decode([Question].self, from:data)
            
        //notify the delegate of the parsed objects
            delegate?.questionsRetrieved(array)
        }
        catch {
            //ERROR: couldn't read the data at that URL
        }
        
    }
    func getRemoteJsonFile(){
        //Get a URL object
        //https://raw.githubusercontent.com/Pableezzy/RSPQuizApp/master/QuestionData.json
        
        let urlString = "https://raw.githubusercontent.com/Pableezzy/RSPQuizApp/master/QuestionData.json"
        
        let url = URL(string: urlString)
        
        guard url != nil else{
            print("Couldn't create the URL object")
            return
        }
        //Get a URL Session object
        let session = URLSession.shared
        //Get a Data task object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            //comnpletion handler code
            
            //check that there wasn't an error & there is data
            if error == nil && data != nil {
                
                do {
                    
                    //Create a JSON Decoder object
                    let decoder = JSONDecoder()
                    //Parse the JSON
                   let array = try decoder.decode([Question].self, from: data!)
                    
                    //Use the main thread to notify the view controller for the UI work
                    DispatchQueue.main.async {
                       //Notify the view controller (Delegate)
                       self.delegate?.questionsRetrieved(array)
                    }
                    
                    //send the data task in a background thread to retrieve the data
                    //pass the data back to the main thread
                    //we want the main thread to update the UI
                    //notify the View Controller as it returns
                    
                }catch {
                    print("Couldn't Parse JSON")
                }
                
                
               
                
            }
            
            
            
        }
       //Call resume on the data task
        dataTask.resume()
        
        
    }
}
