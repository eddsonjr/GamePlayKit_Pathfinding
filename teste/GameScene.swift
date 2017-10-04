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
    
    var nodeStack = Stack<CGPoint>() //Responsavel por armazenar uma pilha contendo as posicoes dos nos do grafo que esta na tela.

    
    //Mark: Estados do animal
    //criando os estados
    let girando = Girando()
    let andando = Andando()
    let mijando = Mijando()
    let farejando = Farejando()
    
    
    //Maquina de estados
    var machineState: GKStateMachine? = nil
    
    
    
    
    override func didMove(to view: SKView) {
        print("Inside didMove...")
        
        
        //Suporte ao grafo desenhado na cena do spritekit
        self.navigationGraph = self.graphs.values.first
        print("Lista de nos do grafo: ")
        print(self.navigationGraph?.nodes)
        
        
        
        //Colocando os pontos do grafo na pilha de pontos
        botarNodesNaPilha()
        
        
        //Configurando o cachorro
        configCachorro()
        
        
        //Inicializando a maquina de estados
        self.machineState = GKStateMachine(states: [farejando,girando,andando,mijando,andando])
        
        //Setando para o cachorro nao mijar
        StateHelper.temQueMijar = false
        
        
        controlarCachorro()
        
        
        
        /*AS FUNCOES ABAIXO SAO DE TESTES ANTIGOS*/
        
        //Pegando um no especifico
//        print("Retornando um nó especifico: \(String(describing: self.navigationGraph?.nodes?[1]))")
//        let testNode: GKGraphNode2D = self.navigationGraph?.nodes![0] as! GKGraphNode2D
//        print("Test Node position: \(CGPoint(testNode.position))")
        
        
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
    
    
    
    
    
    //Mark: Esta funcao serve para pegar cada no do grafo, extrair o seu ponto (CGPoint) e colocar esse ponto em uma pilha, que sera usada posteriormente.
    func botarNodesNaPilha() {
        
        
        for node in stride(from: Int(((self.navigationGraph?.nodes?.count)!-1)), to: 1, by: -1){
            let nodeFromGraph: GKGraphNode2D =  self.navigationGraph?.nodes![node] as! GKGraphNode2D
            self.nodeStack.push(CGPoint(nodeFromGraph.position))
            
        }
        
        print("Quantidade de pontos para o cachorro passar: \(self.nodeStack.items.count)")
        
    }
    
    
    
    
    //Mark: Esta funcao serve para configurar o sprite do cachorro e coloca-lo na primeira posicao do grafo (dando pop na pilha)
    func configCachorro() {
        
        let texturaCachorro = SKTexture(image: #imageLiteral(resourceName: "Cachorro1"))
        StateHelper.cachorro = SKSpriteNode(texture: texturaCachorro)
        StateHelper.cachorro.size = texturaCachorro.size()
        StateHelper.cachorro.alpha = 1.0
        
        //setando a posicao do cachorro (pegando a primeira posicao do grafo.
        StateHelper.cachorro.position = self.nodeStack.pop()
        
        //adicionando o cachorro na lista
        self.addChild(StateHelper.cachorro)
        
        //Colocando uma condicao para nao chamar o proximo estado, ou seja, esperar as animacoes 
        StateHelper.podeChamarProximoEstado = true
        
        
    }
    
    
    
    //Mark: Esta funcao serve para manipular o animal, fazendo ele andar e controlando seus estados
    func controlarCachorro() {
        
        
        if StateHelper.podeChamarProximoEstado! {
            //Entrando nos estados
            if machineState?.enter(Farejando.self) == false  {
                print("Nao foi possivel entrar no estado farejando")
            }
            if machineState?.enter(Mijando.self) == false  {
                print("Nao foi possivel entrar no estado de mijando")
            }
            if machineState?.enter(Girando.self) == false  {
                print("Nao foi possivel entrar no estado de girando")
            }
            if machineState?.enter(Andando.self) == false  {
                print("Nao foi possivel entrar no estado de andar")
            }

        }
        
        
        
        
        
        
//        if StateHelper.podeChamarProximoEstado! {
//            StateHelper.ponto = self.nodeStack.pop()
//            print("Proximo ponto: \(StateHelper.ponto) | Restantes: \(self.nodeStack.items.count) | Pode ir?: \(StateHelper.podeChamarProximoEstado))")
//
    }
}
