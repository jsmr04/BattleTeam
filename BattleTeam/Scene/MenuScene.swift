//
//  MenuScene.swift
//  ColorSwift
//
//  Created by user163027 on 2/24/20.
//  Copyright © 2020 user163027. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    override func didMove(to view: SKView) {
           
        //backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha:1.0)
        self.addChild(addBackground("menuBackground", self.frame))
        addLabels()
    }
    
//    func addBackground(_ nameBackground: String){
//        let background = SKSpriteNode(imageNamed: nameBackground)
//        background.position = CGPoint(x: frame.midX, y: frame.midY)
//        background.size = frame.size
//        background.zPosition = ZPosition.background
//        background.anchorPoint = CGPoint(x: 0.5,y: 0.5)
//
//        self.addChild(background)
//
//    }
    func addLogo(){
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.size = CGSize(width: frame.width / 3, height: frame.width / 3)
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height/4)
        addChild(logo)
    }
    
    func addLabels(){
        let playLabel = SKLabelNode(text: "Tap to Play")
        playLabel.name = "play"
        playLabel.fontName = "AvenirNext-Bold"
        playLabel.fontSize = 90.0
        playLabel.fontColor = UIColor.white
        playLabel.zPosition = ZPosition.label
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY - 60)
        addChild(playLabel)
        animate(label: playLabel)
        
        let scoreLabel = SKLabelNode(text: "Score")
        scoreLabel.name = "score"
        scoreLabel.fontName = "AvenirNext-Bold"
        scoreLabel.fontSize = 65.0
        scoreLabel.fontColor = UIColor.white
        scoreLabel.zPosition = ZPosition.label
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - 140)
        addChild(scoreLabel)
    }
    
    func animate(label: SKLabelNode){
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        
        let sequence = SKAction.sequence([scaleUp, scaleDown])
        label.run(SKAction.repeatForever(sequence))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch?
        
        //If label Score is touched then we go to Score Scene,
        //otherwise we play the game
        if let touchLocation = touch?.location(in: self){
        
            if let targetNode:SKNode? = atPoint(touchLocation){
            
                if let name = targetNode?.name
                {
                    if name == "score"
                    {
                        let scoreScene = ScoreScene(size: view!.bounds.size)
                        view!.presentScene(scoreScene)
                        return
                    }
                }
            }
        }
        
        let gameScene = GameScene(size: view!.bounds.size)
        view!.presentScene(gameScene)
    }
}
