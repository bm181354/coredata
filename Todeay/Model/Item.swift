//
//  Item.swift
//  Todeay
//
//  Created by Biken Maharjan on 4/15/18.
//  Copyright © 2018 Biken Maharjan. All rights reserved.
//

import Foundation


class Item:Codable{
    
    var flag:Bool?
    var value:String?
    
    init(value: String){
    
        self.value = value
        self.flag = false
    }
    
    
}
