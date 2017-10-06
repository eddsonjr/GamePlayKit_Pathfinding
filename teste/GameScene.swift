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
        
        
        girando.stateDelegate = self
        andando.stateDelegate = self
        farejando.stateDelegate = self
        
        
        //Suporte ao grafo desenhado na cena do spritekit
        self.navigationGraph = self.graphs.values.first
        print("Lista de nos do grafo: ")
        print(StateHelper.nodeStack.items)
        
        
        
        //Colocando os pontos do grafo na pilha de pontos
        botarNodesNaPilha()
        
        
        //Configurando o cachorro
        configCachorro()
        
        
        //Inicializando a maquina de estados
        self.machineState = GKStateMachine(states: [farejando,girando,andando,mijando])
        
        
        if !StateHelper.stateInAction {
                if machineState?.enter(Farejando.self) == false {
                    print("Deu erro ao entrar no estado de farejando. Nao foi possivel entrar nele.")
                }
            StateHelper.stateInAction = true
        }

        
        
        
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
        
//        if StateHelper.nodeStack.items.count == 3 {
//            print("TESTE DE MIJANDO, FAZENDO O CACHORRO MIJAR > Estado atual: \(machineState?.currentState)")
//            StateHelper.temQueMijar = true
//            StateHelper.stateInAction = true
//        }
        
        
//        
//        if !StateHelper.stateInAction {
//            //controlarCachorro()
//            if machineState?.enter(Farejando.self) == false {
//                print("Deu erro ao entrar no estado de farejando. Nao foi possivel entrar nele.")
//            }
//            StateHelper.stateInAction = true
//        }
//    }
    }
    
    
    
    //Mark: Esta funcao serve para pegar cada no do grafo, extrair o seu ponto (CGPoint) e colocar esse ponto em uma pilha, que sera usada posteriormente.
    func botarNodesNaPilha() {
        
        
        for node in stride(from: Int(((self.navigationGraph?.nodes?.count)!-1)), to: 1, by: -1){
            let nodeFromGraph: GKGraphNode2D =  self.navigationGraph?.nodes![node] as! GKGraphNode2D
            StateHelper.nodeStack.push(CGPoint(nodeFromGraph.position))
        }
        
        print("Quantidade de pontos para o cachorro passar: \(StateHelper.nodeStack.numberOfElements())")
        
    }
    
    
    
    
    //Mark: Esta funcao serve para configurar o sprite do cachorro e coloca-lo na primeira posicao do grafo (dando pop na pilha)
    func configCachorro() {
        
        let texturaCachorro = SKTexture(image: #imageLiteral(resourceName: "Cachorro1"))
        StateHelper.cachorro = SKSpriteNode(texture: texturaCachorro)
        StateHelper.cachorro.size = texturaCachorro.size()
        StateHelper.cachorro.alpha = 1.0
        
        //setando a posicao do cachorro (pegando a primeira posicao do grafo.
        StateHelper.cachorro.position = StateHelper.nodeStack.pop()
        
        //adicionando o cachorro na lista
        self.addChild(StateHelper.cachorro)
        
        
        
    }
    
    
    
    //Mark: Esta funcao serve para manipular o animal, fazendo ele andar e controlando seus estados
    func controlarCachorro() {
        
        //Entrando nos estados
        if machineState?.enter(Farejando.self) == false   {
            print("Nao foi possivel entrar no estado farejando")
        }else if machineState?.enter(Girando.self) == false {
            print("Nao foi possivel entrar no estado de girando")
        }else if machineState?.enter(Mijando.self) == false {
            print("Nao foi possivel entrar no estado de mijando")
        }else if machineState?.enter(Andando.self) == false {
            print("Nao foi possivel entrar no estado de andando")
        }
    }
    
    
    
}


extension GameScene: StateDelegate {
    
    func stateDelegateSuccess(_ state: GKState) {
        
        
        if !StateHelper.nodeStack.IsEmpty(){
            
            
            switch state {
            case farejando:
                print("Deu sucesso no farejando. Verificando se tem que mijar ou nao...")
                if StateHelper.temQueMijar { //verifica se tem que mijar neste ponto
                    print("Tem que mijar neste ponto. Chamando o estado de mijar...")
                    if machineState?.enter(Mijando.self) == false { //se tiver que mijar, entra no estao de mijando
                        print("Nao foi possivel entrar no estado de mijando. Talvez nao tenha que fazer neste ponto...")
                    }
                }else{
                    if machineState?.enter(Girando.self) == false { //caso contrario passa para o estado de girando.
                        print("Nao foi possivel entrar no estado de girando...")
                    }
                }

                
            case girando:
                print("Deu sucesso no girando. Chamando o estado de andar... ")
                if machineState?.enter(Andando.self) == false{
                    print("Nao foi possivel entrar no estao de girar")
                }
            case andando:
                print("Deu sucesso no andando. Chamando o estado de farejando...")
                if machineState?.enter(Farejando.self) == false {
                    print("Nao foi possivel entrar no estado de andar")
                }
                
            default:
                print("Nao foi possivel entrar no proximo estado apos o \(state))")
            }
        
        }else {
            print("TERMINADO OS PONTOS QUE O CACHORRO DEVERIA PASSAR....")
        }
}
    
    
    
    
    func stateDelegateFail(_ state: GKState) {
        
    }
    
}
