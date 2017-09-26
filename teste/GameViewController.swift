//
//  GameViewController.swift
//  teste
//
//  Created by Edson  Jr on 25/09/17.
//  Copyright © 2017 Edson  Jr. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    private var sceneNode: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                self.sceneNode = sceneNode
                
                self.sceneNode.entities = scene.entities // <-- entities loaded here
                self.sceneNode.graphs = scene.graphs // <-- graphs loaded here
                
                if let view = self.view as! SKView? {
                   
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                    view.presentScene(sceneNode)
                }

                
            }
        }
    }
    
    
    
    
    /*
     self.sceneNode.entities = scene.entities // <-- entities loaded here
     self.sceneNode.graphs = scene.graphs // <-- graphs loaded here
     */

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}







/*
 override func viewDidLoad() {
 super.viewDidLoad()
 
 if let scene = GKScene(fileNamed: "GameScene") {
 
 // Get the SKScene from the loaded GKScene
 if let sceneNode = scene.rootNode as! GameScene? {
 if let view = self.view as! SKView? {
 view.presentScene(sceneNode)
 
 view.ignoresSiblingOrder = true
 
 view.showsFPS = true
 view.showsNodeCount = true
 
 sceneNode.graphs = scene.graphs
 sceneNode.entities = scene.entities
 }
 
 
 }
 
 }

 
 
 
 
 
 */
