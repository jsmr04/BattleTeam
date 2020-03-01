import UIKit

class Weapon
{
    var name : String = "NO GUN"
    var numBullets : Int = 0
    var damage : Int = 0
    var maxNumberOfBullets : Int = 100

    init(gunName : String , gunDamage : Int , numBullet : Int ) {
        self.setNumOfBullets(numberOfBulltes: numBullet)
        self.setDamage(newDamage: gunDamage)
        self.setName(newName: gunName)
    }
    func getName() -> String {
        return self.name
    }
    func setName(newName : String) {
        self.name = newName
    }
    func getNumOfBulltes() -> Int {
        return self.numBullets
    }
    func setNumOfBullets(numberOfBulltes : Int){
        self.numBullets = numberOfBulltes
    }
    func getDamage() -> Int {
        return self.damage
    }
    func setDamage(newDamage : Int){
        self.damage = newDamage
    }
    func setMaxNumberOfBullets(numOfBullets : Int){
        self.maxNumberOfBullets = numOfBullets
    }
    func getNumberOfBullets() -> Int {
        return self.maxNumberOfBullets
    }
    func reload(){
        self.setNumOfBullets(numberOfBulltes: maxNumberOfBullets)
    }
    // abstract method
    static func fire()  {
        preconditionFailure("Method must be overritten")
    }
    
}
