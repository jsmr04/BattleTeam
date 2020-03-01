//
//  Conflict.swift
//  BattleTeam
//
//  Created by Arthur Ataide on 2020-02-29.
//  Copyright © 2020 user163027. All rights reserved.
//

import Foundation

class Conflict{
    
    func fight(_ team1: inout Team, _ team2: inout Team) -> Team{
        var running: Bool = true
        var loser:Team?
       
        while(running){
            let pFrom1 = Int.random(in: 0..<(team1.showPlayers().count))
            let pFrom2 = Int.random(in: 0..<(team2.showPlayers().count))
            
            let index1:Int? = team1.getPlayers().firstIndex(where:{ $0.getName() == team1.showPlayers()[pFrom1].getName()})
            
            let index2:Int? = team2.getPlayers().firstIndex(where:{ $0.getName() == team2.showPlayers()[pFrom2].getName()})
            
            print("index 1 \(pFrom1), 2 \(pFrom2)")
            
            if index2 == nil{
                continue
            }
            
            
            while (team1.getPlayers()[index1!].isAlive() == true && team2.getPlayers()[index2!].isAlive() == true){
                
                team1.getPlayers()[index1!].attack(otherPlayer: team2.getPlayers()[index2!])
                
            }
            
            //Both If statements check if all the Team players has died. If it's true
            //the loop is stopped. It also stores the name of the lost Team on Result
            //and update the weapons of the winner Team
            
            
            print("T1 remaing \(team1.showPlayers().count)")
            if(team1.showPlayers().count == 0){
                print("T1 loses")
                running = false
                loser = team1
                
                for player in team2.showPlayers(){
                    player.upgradeWeapon()
                }
            }
            
            print("T2 remaing \(team2.showPlayers().count)")
            if(team2.showPlayers().count == 0){
                print("T2 loses")
                running = false
                loser = team2
                
                for player in team1.showPlayers(){
                    player.upgradeWeapon()
                }
            }
            
        }
        
        team1.calculateRadius()
        team2.calculateRadius()
        
        return loser!
    }
    init(){
        
    }
}
