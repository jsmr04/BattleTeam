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
    static let team:CGFloat = 0
    static let label:CGFloat = 1
}

enum GameStatus{
    case loading, playing, ended
}

enum Effects{
    case showUp, explosion
}

enum TeamCharacteristic{
    static let defaultSize:CGFloat = 10
}
