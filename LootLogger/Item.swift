//
//  Item.swift
//  LootLogger
//
//  Created by Hamit Sehjal on 2024-02-21.
//


import UIKit

class Item:Equatable{
    var name:String
    var valueInDollars:Int
    var serialNumber:String?
    let dateCreated:Date
    
    // Designated Initializer
    init(name:String,valueInDollars:Int,serialNumber:String?){
        self.name=name
        self.valueInDollars=valueInDollars
        self.serialNumber=serialNumber
        self.dateCreated=Date()
    }
    
    // Convinience Initializer
    convenience init(random:Bool=false){
        if random{
            let adjectives=["Fluffy","Rusty","Shiny"]
            let nouns=["Bear","Spork","Mac"]
            
            // Forced unwrapping ? - we are sure adjectives and nouns array will never be empty
            let randomAdjective=adjectives.randomElement()!
            let randomNoun=nouns.randomElement()!
            
            let randomName="\(randomAdjective) \(randomNoun)"
            let randomValue=Int.random(in: 0..<100)
            let randomSerialNumber=UUID().uuidString.components(separatedBy: "-").first!
            
            
            self.init(name:randomName,valueInDollars: randomValue,serialNumber: randomSerialNumber)
        }else{
            self.init(name:"",valueInDollars: 0,serialNumber: nil)
        }
    }
    
    // overloading == operator
    static func ==(lhs:Item,rhs:Item)->Bool{
        return lhs.name == rhs.name && lhs.valueInDollars==rhs.valueInDollars && lhs.serialNumber==rhs.serialNumber && lhs.dateCreated == rhs.dateCreated
    }
}
