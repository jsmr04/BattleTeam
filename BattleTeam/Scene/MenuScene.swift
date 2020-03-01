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
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha:1.0)
        
        addBackground()
        addLabels()
    }
    
    func addBackground(){
        let background = SKSpriteNode(imageNamed: "mainScreenBackground")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = frame.size
        background.anchorPoint = CGPoint(x: 0.5,y: 0.5)

        self.addChild(background)

    }
    func addLogo(){
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.size = CGSize(width: frame.width / 3, height: frame.width / 3)
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height/4)
        addChild(logo)
    }
    
    func addLabels(){
        let playLabel = SKLabelNode(text: "Tap to Play")
        playLabel.fontName = "AvenirNext-Bold"
        playLabel.fontSize = 90.0
        //playLabel.color = UIColor.white
        playLabel.fontColor = UIColor.black
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        addChild(playLabel)
        animate(label: playLabel)
    }
    
    func animate(label: SKLabelNode){
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        
        let sequence = SKAction.sequence([scaleUp, scaleDown])
        label.run(SKAction.repeatForever(sequence))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        view!.presentScene(gameScene)
    }
}
