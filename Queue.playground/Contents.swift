//: Playground - noun: a place where people can play

import UIKit
import Foundation
import GameplayKit
import SpriteKit




let syncQueue = DispatchQueue(label: "com.queue")

func operation1() {
    print("Operation 1")
    syncQueue.sync { //Running in background task
        for i in 0..<10 {
            print("Item: \(i)")
            
        }
        
        operation2()
    }
}

func operation2() {
    print("Operation 2")
    syncQueue.sync { //Running in background task
        
        for x in 10..<25 {
            print("Item: \(x)")
        }
    }
}


func operation3() {
    print("Operation 3")
    for k in 26..<36 {
        print("Item: \(k)")
    }
}







class Helper {
    static var temQueMijar: Bool!
}


//Variavel para identificar se o animal tem que mijar ou nao
Helper.temQueMijar = true


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





//criando os estados
let girando = Girando()
let andando = Andando()
let mijando = Mijando()
let farejando = Farejando()



//Criando a maquina de estados
let machineState: GKStateMachine = GKStateMachine(states: [farejando,girando,andando,mijando])


//Entando nos estados

if machineState.enter(Farejando.self) == false {
    print("Nao foi possivel entrar no estado farejando")
}

if machineState.enter(Mijando.self) == false {
    print("Nao foi possivel entrar no estado de mijando")
}
if machineState.enter(Girando.self) == false {
    print("Nao foi possivel entrar no estado de girando")
}
if machineState.enter(Andando.self) == false {
    print("Nao foi possivel entrar no estado de andar")
}






