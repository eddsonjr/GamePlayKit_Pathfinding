//
//  GameScene.swift
//  teste
//
//  Created by Edson  Jr on 25/09/17.
//  Copyright © 2017 Edson  Jr. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var navigationGraph: GKGraph?
    
    var player: SKSpriteNode?
    
    var nodeStack = Stack<GKGraphNode2D>() //Responsavel por armazenar uma pilha contendo os nodes do grafo que esta na cena

    
    
    
    override func didMove(to view: SKView) {
        print("Inside didMove...")
        
        
        //Suporte ao grafo desenhado na cena do spritekit
        self.navigationGraph = self.graphs.values.first
        print("Lista de nos do grafo: ")
        print(self.navigationGraph?.nodes)
        
        
        
        //Pegando um no especifico
        print("Retornando um nó especifico: \(String(describing: self.navigationGraph?.nodes?[1]))")
        let testNode: GKGraphNode2D = self.navigationGraph?.nodes![0] as! GKGraphNode2D
        print("Test Node position: \(CGPoint(testNode.position))")
        
        
        //setup player
//        self.player = self.childNode(withName: "player") as? SKSpriteNode
//        self.player?.position = CGPoint(testNode.position)
        
        
        //Tentando animar o personagem andando
       //movePlayer(to: CGPoint(testNode.position), totalOfPoints: (self.navigationGraph?.nodes?.count)!, current: 1)

        
        
    }
    
    
    override func sceneDidLoad() {
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    
    
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
    
        
        
    }
    
    
    
    
    
    
    
    //Mark: Funcao para fazer o personagem caminhar pelo grafo (usando animacao e nao GKAgent2D) - ESTA É UMA FUNCAO SOMENTE DE TESTES
//    func movePlayer(to: CGPoint, totalOfPoints: Int, current: Int){
//        print("MOVENDO O PLAYER. Current: \(current) | Total: \(totalOfPoints)")
//        
//        if current >= totalOfPoints{
//            print("Processo de caminhada do personagem terminado")
//            return
//        }
//        
//        
//        let eTime = DispatchTime.now() + .seconds(2)
//        let moveAnimation = SKAction.move(to: to, duration: 2.5)
//        DispatchQueue.main.asyncAfter(deadline: eTime) {
//            print("Movendo para o ponto: \(to)")
//            self.player?.run(moveAnimation, completion: {
//                print("Animacao terminada")
//                
//                let graphNode: GKGraphNode2D = (self.navigationGraph?.nodes![current] as? GKGraphNode2D)!
//                let graphNodePosition = CGPoint(graphNode.position)
//                let next = current + 1
//                
//                self.movePlayer(to: graphNodePosition, totalOfPoints: (self.navigationGraph?.nodes?.count)!, current: next)
//                
//            })
//        }
//    }
    
    
    
    
    
    
    
    
    

}
