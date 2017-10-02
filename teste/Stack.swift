//
//  Stack.swift
//  Unknow
//
//  Created by Edson  Jr on 10/05/17.
//  Copyright © 2017 Gerson Rodrigo. All rights reserved.
//

import Foundation


/*Pilha generica*/
struct Stack<Element> {
    var items = [Element]()
    
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    
    mutating func pop() -> Element{
        return items.removeLast()
    }
    
    
    mutating func IsEmpty() -> Bool {
        if items.isEmpty {
            return true
        }else {
            return false
        }
    }
    
    
    mutating func clearStack() {
        items.removeAll()
    }
    
    
    mutating func numberOfElements() -> Int {
        return items.count
    }
    
}

