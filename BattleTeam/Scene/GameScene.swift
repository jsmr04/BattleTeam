//
//  GameScene.swift
//  BattleTeam
//
//  Created by user163027 on 2/24/20.
//  Copyright © 2020 user163027. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let bitMarkTeams:Int32 = 1
    var teams:[Team] = [Team]()
    var teamLeft:Int = 0
    var status = GameStatus.loading
    
    func setupPhysics(){
        physicsWorld.gravity = CGVector(dx:0.0, dy:0.0 )
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.collisionBitMask = 1
    }
    
    override func didMove(to view: SKView) {
        setupPhysics()
        addBackground()
        layoutScene()
    }
    func layoutScene(){
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha:1.0)
        
        let defaultSize:CGFloat = frame.size.width / TeamCharacteristic.defaultSize
        var defaultLocationX:CGFloat
        var defaultLocationY:CGFloat
        var yPositionTeamLabel:CGFloat = frame.maxY - 50
        let xPositionTeamLabel:CGFloat = frame.minX + 50
        
        //Creating teams
        teams.append(Team(newName: "Dominican Republic", newColour: UIColor.red, newImageName: "dominican-republic"))
        
        teams.append(Team(newName: "Brazil", newColour: UIColor.green, newImageName: "brazil"))
        
        teams.append(Team(newName: "India", newColour: UIColor.brown, newImageName: "india"))
        
        teams.append(Team(newName: "Canada", newColour: UIColor.orange, newImageName: "canada"))
        
        teams.append(Team(newName: "United States", newColour: UIColor.blue, newImageName: "united-states"))
        
        
        for team in teams{
            //Creating a random number of players
            team.generatePlayers()
            
            //Setting up sprites
            (defaultLocationX, defaultLocationY) = generateRandomLocation()
            team.getSprite().position = CGPoint(x: defaultLocationX, y: defaultLocationY)
            team.getSprite().size = CGSize(width: defaultSize + CGFloat(team.getRadius()) , height: defaultSize + CGFloat(team.getRadius()))
            team.getSprite().physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: team.getImageName()), size: CGSize(width: defaultSize + CGFloat(team.getRadius()) , height: defaultSize + CGFloat(team.getRadius())))
            team.getSprite().physicsBody?.allowsRotation = false
            team.getSprite().physicsBody?.categoryBitMask = PhysicsCategories.teamCategory
            team.getSprite().physicsBody?.contactTestBitMask = PhysicsCategories.teamCategory
            team.getSprite().zPosition = ZPosition.team
            
            //Adding sprite into the scene
            self.addChild(team.getSprite())
            
            //Creating label of the team
            addTeamLabel(team: team, position: CGPoint(x:xPositionTeamLabel, y:yPositionTeamLabel))
            yPositionTeamLabel -= 25
        }
        
        teamLeft = teams.count
        
        showTeams()
    }
    
    
    
    func addTeamLabel(team:Team, position:CGPoint){
        let teamLabel = SKLabelNode(text: "\(team.getName()): \(team.getPlayers().count)")
        teamLabel.name = "\(team.getName())_label"
        teamLabel.fontColor = UIColor.white
        teamLabel.fontSize = 25
        teamLabel.horizontalAlignmentMode = .left
        teamLabel.fontName = "Helvetica-Bold"
        teamLabel.position = position
        teamLabel.zPosition = ZPosition.label
        addChild(teamLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if status == .ended{
            let gameScene = MenuScene(size: view!.bounds.size)
            view!.presentScene(gameScene)
        }
    }
    
    func play(){
        //Changing game's status
        status = .playing
        //Activating contact
        physicsWorld.contactDelegate = self
        //Move sprites toward the center of the screen
        moveSprites()
    }
    
    func start(){
        //Preparing label
        let startLabel = SKLabelNode(text: "Start")
        startLabel.color = UIColor.white
        startLabel.fontSize = 100
        startLabel.fontName = "Helvetica-Bold"
        startLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        startLabel.isHidden = true
        startLabel.zPosition = ZPosition.label
        addChild(startLabel)
        
        //Preparing animation
        let scaleUp = SKAction.scale(to: 3.5, duration: 0.5)
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let sequence = SKAction.sequence([scaleUp, fadeOut])
        
            self.run(SKAction.wait(forDuration: 1),completion: {
                startLabel.isHidden = false
                startLabel.run(sequence, completion: {
                self.play()
            })
        })
    }
    
    func generateRandomLocation() -> (CGFloat, CGFloat)  {
        let X:CGFloat = CGFloat.random(in: 0 ... frame.maxX)
        let Y:CGFloat = CGFloat.random(in: 0 ... frame.maxY)
        //let X:CGFloat = CGFloat(arc4random_uniform(UInt32(frame.maxX)))
        //let Y:CGFloat = CGFloat(arc4random_uniform(UInt32(frame.maxY)))
        //arc4random_uniform
        return (X, Y)
    }
    
    
    
    func moveSprites(){
        let move:SKAction
        move = SKAction.move(to: CGPoint(x: self.frame.midX, y: self.frame.midY), duration: 8)
        
        for team in self.teams{
            team.getSprite().run(move, withKey: "move")
        }
    }
    
    func stopSprites(){
        for team in self.teams{
            team.getSprite().removeAction(forKey: "move")
        }
    }
    
    func flagEffect(_ flagName:String) -> [SKTexture] {
        var img: String = ""
        var frames: [SKTexture] = [SKTexture]()
        
        for i in 0 ... 10{
           img =  "flag_\(flagName)_\(String(format:"%02d", i))"
           frames.append(SKTexture.init(imageNamed:img))
        }
        
        return frames
    }
    
    func effect(_ type:Effects) -> [SKTexture] {
        var img: String = ""
        var frames: [SKTexture] = [SKTexture]()
        if type == Effects.explosion{
            for i in 0 ... 14{
                img =  "explosion_\(String(format:"%02d", i))"
                frames.append(SKTexture.init(imageNamed:img))
            }
        }else if type == Effects.showUp{
            for i in 0 ... 16{
                img =  "thunder_\(String(format:"%02d", i))"
                frames.append(SKTexture.init(imageNamed:img))
            }

        }
        
        return frames
    }
    func addBackground(){
        let background = SKSpriteNode(imageNamed: "gameBackground")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = frame.size
        background.anchorPoint = CGPoint(x: 0.5,y: 0.5)

        self.addChild(background)

    }
    
    func showTeams(){
        //Preparing animation
        let texture:[SKTexture] = effect(.showUp)
        let animation = SKAction.animate(with: texture, timePerFrame: 0.1, resize: false, restore: true)
        let wait = SKAction.wait(forDuration: 1)
        let sequence = SKAction.sequence([animation, wait])
        var count:Int = 0
        
        for team in self.teams {
            count = count + 1
            team.getSprite().run(sequence, completion: {
                if count == self.teams.count{
                    //Start after loop the last item
                    self.start()
                }
            })
        }
    }
    
    func getTeamByName(teamName:String)->Team{
        
        let index:Int? = self.teams.firstIndex(where: { $0.getName() == teamName })
        
        return teams[index!]
    }
    
    func getIndexOfTeamByName(teamName:String)->Int{
        
        let index:Int? = self.teams.firstIndex(where: { $0.getName() == teamName })
        
        return index ?? -1
    }
    
   
    func showWinner(team:Team){
        let winnerLabel = SKLabelNode(text: "Winner")
        winnerLabel.color = UIColor.white
        winnerLabel.fontSize = 200
        winnerLabel.fontName = "Helvetica-Bold"
        winnerLabel.position = CGPoint(x: frame.midX, y: frame.midY + winnerLabel.frame.height)
        winnerLabel.zPosition = ZPosition.label
        addChild(winnerLabel)
        
        let fadeOut = SKAction.fadeOut(withDuration: 0.01)
        let fadeIn = SKAction.fadeIn(withDuration: 1.5)
        
        let sound = SKAction.playSoundFileNamed("ff_victory.mp3", waitForCompletion: false)
        run(sound)
        
        winnerLabel.run( SKAction.sequence([fadeOut, fadeIn]), completion: {
            self.animateFlagWinner(teamName:team.getImageName())
            self.status = .ended
            self.saveScore(team: team)
        })
    }
    
    func animateFlagWinner(teamName:String){
        let flag = SKSpriteNode(imageNamed:"flag_\(teamName)_00")
        flag.size = CGSize(width: self.frame.maxX / 2, height:  self.frame.maxX / 3)
        flag.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(flag)
        flag.zPosition = ZPosition.label
        
        let texture = flagEffect(teamName)
        let animation = SKAction.animate(with: texture, timePerFrame: 0.2)
        flag.run(SKAction.repeatForever(animation))
        
    }
    
    func updateLabel(team:Team){
        let label:SKLabelNode = self.childNode(withName: team.getName() + "_label") as! SKLabelNode
        
        if team.showPlayers().count <= 0{
            label.fontColor = UIColor.red
        }
        label.text = "\(team.getName()): \(team.showPlayers().count)"
        
        //TODO: Working here
    }
    
    func updateSize(team:Team){
        let defaultSize:CGFloat = frame.size.width / TeamCharacteristic.defaultSize

        team.getSprite().size = CGSize(width: defaultSize + CGFloat(team.getRadius()), height: defaultSize + CGFloat(team.getRadius()))
        team.getSprite().physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: team.getImageName()), size: CGSize(width: defaultSize + CGFloat(team.getRadius()) , height: defaultSize + CGFloat(team.getRadius())))
        team.getSprite().physicsBody?.allowsRotation = false
        team.getSprite().physicsBody?.categoryBitMask = PhysicsCategories.teamCategory
        team.getSprite().physicsBody?.contactTestBitMask = PhysicsCategories.teamCategory
        team.getSprite().zPosition = ZPosition.team
        
        run(SKAction.wait(forDuration: 1))
            print("Resize \(team.getName())")
        
    }
    
    func destroyTeam(team:Team){
        
        let texture:[SKTexture] = effect(.explosion)
        let animation = SKAction.animate(with: texture, timePerFrame: 0.2)
        let sound = SKAction.playSoundFileNamed("bomb.wav", waitForCompletion: false)
        let sequence = SKAction.sequence([sound, animation])
        
        team.getSprite().run(sequence,completion: {
            //Removing sprite from the scene
            team.getSprite().removeFromParent()
            //Removing team from the list
            //self.teams.remove(at: self.getIndexTeamByName(teamName: team.getName()))
            let index:Int? = self.teams.firstIndex(where: { $0.getName() == team.getName() })
            
            if index! >= 0{
                self.teams.remove(at: index!)
                print("removing \(team.getName()), index \(index!)")
            }
                
            if self.checkWinner(){
               self.stopSprites()
                print("Winner: \(self.teams[0].getName())")
                self.showWinner(team: self.teams[0])
            }else{
               self.moveSprites()
            }
        })
        
    }
    
    func playSound(soundVariable : SKAction)
    {
        run(soundVariable)
    }
    
    func saveScore(team:Team){
        var score:Int = 0
        score = UserDefaults.standard.integer(forKey: "score_" + team.getName())
        //Increasing number of victories
        score = score + 1
        print("New score \(score)")
        //Updating score
        UserDefaults.standard.set(score, forKey: "score_" + team.getName())
        
    }
    func checkWinner() -> Bool{
        var check:Bool = false
        teamLeft = teamLeft - 1
        if teamLeft == 1{
            check = true
            print("Only one")
        }
        return check
    }
}

extension GameScene:SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        let conflict = Conflict.init()
        
        if status == GameStatus.playing{
        if contact.bodyA.categoryBitMask == PhysicsCategories.teamCategory && contact.bodyB.categoryBitMask == PhysicsCategories.teamCategory {
            
            self.stopSprites()
            
            let teamAName = contact.bodyA.node?.name ?? ""
            let teamBName = contact.bodyB.node?.name ?? ""
            
            if teamAName != "" || teamAName != ""{
            
                let indexA:Int = self.getIndexOfTeamByName(teamName:teamAName)
                let indexB:Int = self.getIndexOfTeamByName(teamName:teamBName)
                
                if indexA >= 0 && indexB >= 0 {
                    
                    var teamA = teams[indexA]
                    var teamB = teams[indexB]
            
            if teamA.showPlayers().count > 0 && teamB.showPlayers().count > 0{
                
                let loser = conflict.fight(&teamA, &teamB)
                print("Loser is \(loser.getName())")
                
                //Destroying the team that has lost
                destroyTeam(team: loser)
                
                //resize of the team that has won
                if loser.isEqual(teamA){
                    updateSize(team: teamB)
                }else{
                    updateSize(team: teamA)
                }
                //updateSize(team:  ? teamA : teamB)
                
                //Updating the labels
                updateLabel(team: teamA)
                updateLabel(team: teamB)
                
            }
                }
            }
            }
        }
    }
    
    
}
