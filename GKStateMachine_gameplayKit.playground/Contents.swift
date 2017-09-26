//: Playground - noun: a place where people can play

import UIKit
import GameKit

class Green: GKState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is Yellow.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        print("Traffic light is green")
    }
}

class Yellow: GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is Red.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        print("Traffic light is yellow")
    }
    
}

class Red: GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is Green.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        print("Traffic light is red")
    }
}



// Create the states
let green = Green()
let yellow = Yellow()
let red = Red()

var stateMachine: GKStateMachine?

// Initialize the state machine
stateMachine = GKStateMachine(states: [green, yellow, red])



if stateMachine?.enter(Green.self) == false {
    print("failed to move to green")
}
if stateMachine?.enter(Red.self) == false {
    print("failed to move to red")
}
if stateMachine?.enter(Yellow.self) == false {
    print("failed to move to yellow")
}
if stateMachine?.enter(Green.self) == false {
    print("failed to move to green")
}
if stateMachine?.enter(Red.self) == false {
    print("failed to move to red")
}






//class ViewController: UIViewController {
//    
//    var stateMachine: GKStateMachine?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Create the states
//        let green = Green()
//        let yellow = Yellow()
//        let red = Red()
//        
//        // Initialize the state machine
//        stateMachine = GKStateMachine(states: [green, yellow, red])
//        
//        // Try entering various states...
//        if stateMachine?.enter(Green.self) == false {
//            print("failed to move to green")
//        }
//        if stateMachine?.enter(Red.self) == false {
//            print("failed to move to red")
//        }
//        if stateMachine?.enter(Yellow.self) == false {
//            print("failed to move to yellow")
//        }
//        if stateMachine?.enter(Green.self) == false {
//            print("failed to move to green")
//        }
//        if stateMachine?.enter(Red.self) == false {
//            print("failed to move to red")
//        }
//        
//    }
//    
//}
