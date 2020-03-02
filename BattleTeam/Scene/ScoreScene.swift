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
        showLabels()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let menuScene = MenuScene(size: view!.bounds.size)
        view!.presentScene(menuScene)
    }
    
    func showLabels(){
        var positionY:CGFloat = (frame.maxY - frame.maxY / 4)
        
        let headLabel = SKLabelNode(text: "Score")
        headLabel.fontColor = UIColor.white
        headLabel.fontSize = 100
        headLabel.horizontalAlignmentMode = .center
        headLabel.fontName = "Helvetica-Bold"
        headLabel.position = CGPoint(x: frame.midX, y: positionY)
        headLabel.zPosition = ZPosition.label
        
        positionY = positionY - (headLabel.frame.height + 30)
        
        addChild(headLabel)
        
        for (key, value) in UserDefaults.standard.dictionaryRepresentation(){
            if key.starts(with: "score_"){
                print("\(key), \(value)")
                var text = key.replacingOccurrences(of: "score_", with: "")
                let teamLabel = SKLabelNode(text: "\(text): \(value)")
                teamLabel.fontColor = UIColor.white
                teamLabel.fontSize = 80
                teamLabel.horizontalAlignmentMode = .left
                teamLabel.fontName = "Helvetica-Bold"
                teamLabel.position = CGPoint(x: frame.minX + 50, y: positionY)
                teamLabel.zPosition = ZPosition.label
                
                positionY = positionY - (teamLabel.frame.height + 30)
                
                addChild(teamLabel)
            }
        }
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

