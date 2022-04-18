//
//  Strains.swift
//  MitchellAntoine_DankTank
//
//  Created by Antoine Mitchell on 4/17/22.
//

import Foundation

class Strains {
    
    /* Stored Properties */
    let nameOf: String
    let infoOf: String
    let effectsOf: String
    let imageUrl: String
    let conditionOf: String
    let typeOf: String
    
    /* Initialziers */
    
    init(name: String, info: String, effects: String, imageUrl: String, condition: String, type: String) {
        
        self.nameOf = name
        self.infoOf = info
        self.effectsOf = effects
        self.imageUrl = imageUrl
        self.conditionOf = condition
        self.typeOf = type
        
    }
    
}
