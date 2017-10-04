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


protocol StateDelegate: class {
    func stateDelegateSuccess(_ state: GKState )
    func stateDelegateFail(_ state: GKState )
}


class StateHelper {
    static var temQueMijar: Bool!
    static var cachorro: SKSpriteNode!
    static var podeChamarProximoEstado: Bool?
    static var ponto: CGPoint?
    static var stateInAction: Bool = false
}





class Girando: GKState {
    
    weak var stateDelegate: StateDelegate?
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is Andando.Type
    }
    
    
    override func didEnter(from previousState: GKState?) {
        print("[STATE] >> Girando ")
        let deadlineTime = DispatchTime.now() + .seconds(3)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            print("   >>Girando ... estava no intervalo...")
            self.stateDelegate?.stateDelegateSuccess(self)
        }
    }
    
    override func willExit(to nextState: GKState) {
        print("   >>Saindo do estado de girando")
       
    }
    
}




class Andando: GKState {
    
    weak var stateDelegate: StateDelegate?

    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is Farejando.Type
    }
    
    
    override func didEnter(from previousState: GKState?) {
       
        print("[STATE] >> Andando ")
        let deadlineTime = DispatchTime.now() + .seconds(3)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            print("   >>Andando -- estava no delay...")
            self.stateDelegate?.stateDelegateSuccess(self)
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
       
        print("[STATE] >> Mijando")
        
    }
    
    
    override func willExit(to nextState: GKState) {
        print("   >>Saindo do estado de mijando")
      
        
    }
    
}


class Farejando: GKState {
    
    weak var stateDelegate: StateDelegate?
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
        print("[STATE] >> Farejando ")
        
        let deadlineTime = DispatchTime.now() + .seconds(3)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            print("   >>Girando...")
            self.stateDelegate?.stateDelegateSuccess(self)
        }
        
       
        
    }
    
    
    override func willExit(to nextState: GKState) {
        print("   >> Saindo do estado de farejando. ")
        
    }
}

