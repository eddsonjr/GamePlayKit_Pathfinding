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
    static var stateInAction: Bool = false
    static var nodeStack = Stack<CGPoint>()
    static var irProximoPonto: Bool = false
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
            self.stateDelegate?.stateDelegateSuccess(self)
            
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
        let moveAnimation = SKAction.move(to: StateHelper.nodeStack.pop(), duration: 2.0)
        StateHelper.cachorro.run(moveAnimation, completion: {
             print("Terminou a animacao de Andar")
             self.stateDelegate?.stateDelegateSuccess(self)
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
        
        
        
        /*Talvez o alerta do botao nao possa ficar aqui*/
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alert = SCLAlertView(appearance: appearance)
        alert.addButton(NSLocalizedString("Ok", comment: "Ok"), action: {
            print("Botao do alerta do xixi pressionado!")
            StateHelper.temQueMijar = false
            StateHelper.stateInAction = false
            self.stateDelegate?.stateDelegateSuccess(self)
            
            
        })
        
        alert.showWarning(NSLocalizedString("Oops!", comment: "Opa!"), subTitle: NSLocalizedString("Your pet peed out of the crib. You must take an action.", comment: "O seu pet fez xixi fora do berço. Você deve fazer uma ação."))
        

        
        
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
            print("   >>Terminou de farejar...")
          
            self.stateDelegate?.stateDelegateSuccess(self)
        }
        
       
        
    }
    
    
    override func willExit(to nextState: GKState) {
        print("   >> Saindo do estado de farejando. ")
        
    }
}

