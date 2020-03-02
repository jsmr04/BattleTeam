//
//  Weapon.swift
//  BattleTeam
//
//  Created by user163027 on 2/25/20.
//  Copyright © 2020 user163027. All rights reserved.
//

protocol WeaponDelegate {
    
    func getName() -> String
    func setName(name: String)
    func getNumBullets() -> Int
    func setNumBullets(numBullets :Int)
    func getDamage() -> Int
    func setDamage(damage :Int)
    func reload() -> Int
    func fire() -> Int
}
