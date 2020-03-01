import UIKit
import SpriteKit
class Team
{
    private var name : String
    private var colour : UIColor
    private var radius : Int
    private var status : Bool
    private var imageName: String
    private var sprite: SKSpriteNode?
    private var players : [Player]
    private var checkedPlayers : [Player]
    private static let MAX_NUMBER_OF_PLAYER : Int = 20
    private static let MIN_NUMBER_OF_PLAYER : Int = 1
    private static let BASE_RADIUS : Int = 10
    
    
    
    func getName() -> String {
        return self.name
    }
    func setName(newName : String){
        self.name = newName
    }
    func getColour() -> UIColor {
        return self.colour
    }
    func setColour(newColour : UIColor){
        self.colour = newColour
    }
    
    func getRadius() -> Int {
        return self.radius
    }
    func getImageName() -> String {
        return self.imageName
    }
    func setImageName(newImageName : String){
        self.imageName = newImageName
    }
    func getSprite() -> SKSpriteNode {
        return self.sprite!//TODO: Implement handling exceptions
    }
    func getPlayers() -> [Player] {
        return self.players
    }
    func setPlayers(newPlayers : [Player]){
        self.players = newPlayers
    }
    func showPlayers() -> [Player]{
        checkedPlayers = [Player]()
        for p in self.getPlayers(){
            if p.isAlive(){
                checkedPlayers.append(p)
            }
        }
        return checkedPlayers
    }
    
    init(newName:String, newColour:UIColor, newImageName:String){
        self.name = newName
        self.colour = newColour
        self.radius = 0
        self.status = true
        self.imageName = newImageName
        self.players = [Player]()
        self.checkedPlayers = [Player]()
        
        //Creating Sprite
        sprite = SKSpriteNode(imageNamed: self.imageName)
        sprite?.name = self.name
    }
    
    func generatePlayers() {
        let numberPlayers: Int = Int.random(in: Team.self.MIN_NUMBER_OF_PLAYER ... Team.self.MAX_NUMBER_OF_PLAYER)
              
        for i in 1 ... numberPlayers{
            self.players.append(Player(pName: self.name + "_P\(String(i))", pHealth: 100))
        }
        
        self.calculateRadius()
    }
    
    func isEqual(_ team: Team) -> Bool{
        return self.getName() == team.getName()
    }
    
    func calculateRadius(){
        self.radius = self.showPlayers().count * Team.self.BASE_RADIUS
    }
}
