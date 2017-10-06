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
    static var temQueMijar: Bool = false
    static var cachorro: SKSpriteNode!
    static var nodeStack = Stack<CGPoint>()
    static var nextPoint: CGPoint? = nil
}





class Girando: GKState {
    
    weak var stateDelegate: StateDelegate?
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is Andando.Type
    }
    
    
    override func didEnter(from previousState: GKState?) {
        print("[STATE] >> Girando ")
        
        //Animacao do cachorro girando...
        let rotateAnimation = SKAction.rotate(toAngle: CGFloat(45), duration: 2.0)
        StateHelper.cachorro.run(rotateAnimation, completion: {
            print("Terminou a animacao de girar o cachorro..")
            self.stateDelegate?.stateDelegateSuccess(self) //retorna o delegate dele para conseguir ir para o proximo estado
            
        })

        
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
        
        
        //Animacao do cachorro andando
        let moveAnimation = SKAction.move(to: StateHelper.nextPoint!, duration: 2.0)
        StateHelper.cachorro.run(moveAnimation, completion: {
             print("Terminou a animacao de Andar")
             self.stateDelegate?.stateDelegateSuccess(self) //retorna o delegate dele para conseguir ir para o proximo estado
        })
    }
    
    
    override func willExit(to nextState: GKState) {
        print("   >>Saindo do estado de Andando")
       
    }
    
    
}



class Mijando: GKState {
    
    weak var stateDelegate: StateDelegate?
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is Girando.Type
    }
    
    
    override func didEnter(from previousState: GKState?) {
        print("[STATE] >> Mijando")
        /*Falta a animacao do xixi sendo feito*/
        self.stateDelegate?.stateDelegateSuccess(self) //retorna o delegate dele para conseguir ir para o proximo estado
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
    
        
        /*Verificar se e cabivel alguma animacao ou somente o delay aqui*/
        let deadlineTime = DispatchTime.now() + .seconds(3)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            print("   >>Terminou de farejar...")
            self.stateDelegate?.stateDelegateSuccess(self) //retorna o delegate dele para conseguir ir para o proximo estado
        }
        
       
        
    }
    override func willExit(to nextState: GKState) {
        print("   >> Saindo do estado de farejando. ")
        //Pegando o proximo ponto do path no qual o cachorro tem que passar
        StateHelper.nextPoint = StateHelper.nodeStack.pop()

        
    }
}

