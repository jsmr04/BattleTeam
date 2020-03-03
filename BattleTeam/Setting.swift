//
//  Setting.swift
//  BattleTeam
//
//  Created by user163027 on 2/25/20.
//  Copyright © 2020 user163027. All rights reserved.
//

import SpriteKit

enum PhysicsCategories{
    static let teamCategory:UInt32 = 0x1
}

enum ZPosition{
    static let background:CGFloat = 0
    static let team:CGFloat = 1
    static let label:CGFloat = 2
}

enum GameStatus{
    case loading, playing, ended
}

enum Effects{
    case showUp, explosion
}

enum TeamCharacteristic{
    static let defaultSize:CGFloat = 15
}

func addBackground(_ nameBackground: String, _ frame: CGRect  ) -> SKSpriteNode{
    let background = SKSpriteNode(imageNamed: nameBackground)
    background.position = CGPoint(x: frame.midX, y: frame.midY)
    background.size = frame.size
    background.zPosition = ZPosition.background
    background.anchorPoint = CGPoint(x: 0.5,y: 0.5)
    
    return background
    //self.addChild(background)

}
