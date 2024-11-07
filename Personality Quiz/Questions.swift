//
//  Questions.swift
//  Personality Quiz
//
//  Created by Batch-2 on 15/04/24.
//

import Foundation

struct Question
{
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType
{
    case single, multiple, ranged
}



struct Answer
{
    var text: String
    var type: AnimalType
}

enum AnimalType: Character
{
    case unicorn = "🦄", chick = "🐣", dog = "🐶", penguin = "🐧"
    
    var definition: String
    {
        switch self
        {
        case .unicorn:
            return "You are really creative and magical"
            
        case .chick:
            return "Happy-go-lucky with a bubbly personality and extroverted nature"
            
        case .dog:
            return "Loyal, wise and ambivert. Mischievous, yet mild-tempered, you enjoy doing things on your own terms"
            
        case .penguin:
            return "Introverted and really perceptive"
            
        }
    }
}


