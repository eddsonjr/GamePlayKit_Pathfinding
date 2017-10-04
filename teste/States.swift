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


class StateHelper {
    static var temQueMijar: Bool!
    static var cachorro: SKSpriteNode!
    static var podeChamarProximoEstado: Bool?
    static var ponto: CGPoint?
}





class Girando: GKState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is Andando.Type
    }
    
    
    override func didEnter(from previousState: GKState?) {
        print("[STATE] >> Girando o cachorro")
        let deadlineTime = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            print("Ja executou o didEnter do girando")
        }

        

        
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
        
        let deadlineTime = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            print("Ja executou o didEnter do andando")
        }

       

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
        let deadlineTime = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            print("Ja executou o didEnter do mijando")
        }

        
    }
    
    
    override func willExit(to nextState: GKState) {
        print("   >>Saindo do estado de mijando")
      
        
    }
    
}


class Farejando: GKState {
    
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if StateHelper.temQueMijar {
            print("   >>Tem que mijar<<")
            return stateClass is Mijando.Type
        }else{
            print("   >>Nao tem que mijar<<")
            return  stateClass is Girando.Type
        }
        
    }
    
    
    
    override func didEnter(from previousState: GKState?) {
        print("[STATE] >> Farejando")
        
        let deadlineTime = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            print("Ja executou o didEnter do farejando")
        }
        
    }
    
    
    override func willExit(to nextState: GKState) {
        print("   >> Saindo do estado de farejando. ")
        
    }
}

