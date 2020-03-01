//
//  Conflict.swift
//  BattleTeam
//
//  Created by Arthur Ataide on 2020-02-29.
//  Copyright © 2020 user163027. All rights reserved.
//

import Foundation

class Conflict{
    
    func fight(_ team1: Team, _ team2: Team) -> String{
        var result: String = ""
        var running: Bool = true
        while(running){
            let pFrom1 = Int.random(in: 0..<(team1.getPlayers().count))
            let pFrom2 = Int.random(in: 0..<(team2.getPlayers().count))
            
            if (team1.getPlayers()[pFrom1].isAlive() == false || team2.getPlayers()[pFrom2].isAlive() == false){
                continue
            }
            
            while (team1.getPlayers()[pFrom1].isAlive() == true && team2.getPlayers()[pFrom2].isAlive() == true){
                
                team1.getPlayers()[pFrom1].attack(otherPlayer: team2.getPlayers()[pFrom2])
            }
            
            //Both If statements check if all the Team players has died. If it's true
            //the loop is stopped. It also stores the name of the lost Team on Result
            //and update the weapons of the winner Team
            
            if(team1.showPlayers().isEmpty){
                running = false
                result = team1.getName()
                
                for player in team2.showPlayers(){
                    player.upgradeWeapon()
                }
            }
            if(team2.showPlayers().isEmpty){
                running = false
                result = team2.getName()
                
                for player in team1.showPlayers(){
                    player.upgradeWeapon()
                }
            }
        }
        
        team1.calculateRadius()
        team2.calculateRadius()
        
        return result
    }
    init(){
        
    }
}
