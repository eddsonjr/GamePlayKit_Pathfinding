//
//  States.swift
//  teste
//
//  Created by Edson  Jr on 29/09/17.
//  Copyright © 2017 Edson  Jr. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit


class Helper {
    static var temQueMijar: Bool!
    static var cachorro: SKSpriteNode!
    
}





class Girando: GKState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is Andando.Type
    }
    
    
    override func didEnter(from previousState: GKState?) {
        print("[STATE] >> Girando o cachorro")
        
    }
    
    override func willExit(to nextState: GKState) {
        print("   >>Saindo do estado de girando")
    }
    
}


class Andando: GKState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is Farejando.Type
    }
    
    
    override func didEnter(from previousState: GKState?) {
        print("[STATE] >> O cachorro andando.")
    }
    
    
    override func willExit(to nextState: GKState) {
        print("   >>Saindo do estado de Andando")
    }
    
    
}



class Mijando: GKState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is Girando.Type
    }
    
    
    override func didEnter(from previousState: GKState?) {
        print("[STATE] >> Mijando...")
    }
    
    
    override func willExit(to nextState: GKState) {
        print("   >>Saindo do estado de mijando")
    }
    
}


class Farejando: GKState {
    
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if Helper.temQueMijar {
            print("   >>Tem que mijar<<")
            return stateClass is Mijando.Type
        }else{
            print("   >>Nao tem que mijar<<")
            return  stateClass is Girando.Type
        }
        
    }
    
    
    
    override func didEnter(from previousState: GKState?) {
        print("[STATE] >> Farejando")
    }
}

