//
//  Weapon.swift
//  Weapon
//
//  Created by Jaldeep Patel on 2020-02-26.
//  Copyright © 2020 Jaldeep Patel. All rights reserved.
//

import UIKit

// Parent Weapon Class
public class Weapon:WeaponDelegate {
    private var name: String
    private var numBullets: Int
    internal var damage :Int
    private let maxNoOfBullets: Int = 30
    internal static let DEFAULT_DAMAGE = 10

    func getName() -> String {
        return self.name
    }
    func setName(name: String) {
        self.name = name
    }
    func getNumBullets() -> Int {
        return self.numBullets
    }
    func setNumBullets(numBullets :Int) {
        self.numBullets = numBullets
    }
    func getDamage() -> Int {
        return self.damage
    }
    func setDamage(damage :Int) {
        self.damage = damage
    }
    
//Constructor of Class Weapon
    init(_ numBullets :Int, _ name: String, _ newDamage:Int) {
        self.numBullets = numBullets
        self.name = name
        self.damage = newDamage
    }
    
//Function reload to set number of bullets to maximum numbers of bullets
    func reload() -> Int {
        self.setNumBullets(numBullets: self.maxNoOfBullets)
        return self.getNumBullets()
    }

    func fire() -> Int {
        return 0
    }
}



