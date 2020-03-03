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
        //addBackground("scoreBackground")
        self.addChild(addBackground("scoreBackground", self.frame))
        showLabels()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let menuScene = MenuScene(size: view!.bounds.size)
        view!.presentScene(menuScene)
    }
    
    func showLabels(){
        var positionY:CGFloat = (frame.maxY - frame.maxY / 4)
        var teamScore: [String: Int] = [:]
        
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
                let text = key.replacingOccurrences(of: "score_", with: "")
                teamScore[text] = (value as! Int)
            }
        }
        
        let sortedArray = teamScore.sorted{$0.1 > $1.1}
        
        for p in sortedArray{
            
            let teamLabel = SKLabelNode(text: "\(p.key): \(p.value)")
            teamLabel.fontColor = UIColor.white
            teamLabel.fontSize = 65
            teamLabel.horizontalAlignmentMode = .left
            teamLabel.fontName = "Helvetica-Bold"
            teamLabel.position = CGPoint(x: frame.minX + 50, y: positionY)
            teamLabel.zPosition = ZPosition.label
            
            positionY = positionY - (teamLabel.frame.height + 30)
            
            addChild(teamLabel)
        }
        
        
    }
}

