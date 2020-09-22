//
//  Question.swift
//  QuizApp
//
//  Created by Pablo Zepeda on 8/29/20.
//  Copyright © 2020 Pablo Zepeda. All rights reserved.
//

import Foundation

struct Question: Codable {
    var question:String?
    var answers:[String]?
    var correctAnswerIndex:Int?
    var feedback:String?
}
