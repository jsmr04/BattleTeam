//
//  ScoreScene.swift
//  BattleTeam
//
//  Created by user163027 on 3/2/20.
//  Copyright © 2020 user163027. All rights reserved.
//

import SpriteKit

class ScoreScene: SKScene {
    
    override func didMove(to view: SKView) {
        addBackground()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let menuScene = MenuScene(size: view!.bounds.size)
        view!.presentScene(menuScene)
    }

    func addBackground(){
        let background = SKSpriteNode(imageNamed: "mainScreenBackground")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = frame.size
        background.zPosition = ZPosition.background
        background.anchorPoint = CGPoint(x: 0.5,y: 0.5)

        self.addChild(background)

    }
}

