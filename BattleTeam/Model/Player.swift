class Player{
    
    private static var HEALTH_INCREASE_BY = 2
    private var health: Int
    private var name: String
    private var selectedWeapon : Int = 0
    private static var MAX_HEALTH : Int = 100
    private var alive : Bool
    var weaponsDelegate:[WeaponDelegate]
    
    // CONSTUCTOR
    init(pName : String , pHealth : Int ){
        self.name = pName
        self.health = pHealth
        self.alive = true

        self.weaponsDelegate = [WeaponDelegate]()
        
        self.weaponsDelegate.append(NightHawk(numBullets: 30, name: "NightHawk"))
        self.weaponsDelegate.append(UMP(numBullets: 30, name: "UMP"))
        self.weaponsDelegate.append(Maverick(numBullets: 30, name: "Maverick"))
        self.weaponsDelegate.append(Bullup(numBullets: 30, name: "Bullup"))
        self.weaponsDelegate.append(M249(numBullets: 30, name: "M249"))

        self.selectedWeapon = 0
    }
    
    func isAlive() -> Bool{
        if self.alive == true{
            if self.getHealth() < 1 {
                self.setAlive(alive: false)
            }
        }
        return self.alive
    }
    
    func setAlive(alive : Bool){
        self.alive = alive
    }
    
    func getName() -> String{
        return self.name
    }
    
    func getWeapon() -> [WeaponDelegate]{
        return self.weaponsDelegate
    }
    
    func getSelectedWeapon() -> Int {
        return self.selectedWeapon
    }
    
    func addWeapon(weapon : WeaponDelegate) {
        self.weaponsDelegate.append(weapon)
    }
    
    func setSelectedWeapon(selectedWeapon : Int)
    {
        self.selectedWeapon = selectedWeapon
    }
    
    func setHealth(health : Int) throws
    {
        if health > Player.MAX_HEALTH{
            throw PlayerError.healthGraterThanDefaultExcepcion("New health exceeds maximum health allowed, \(Player.MAX_HEALTH)")
        }else{
            self.health = health
        }
        
        
    }
    
    func getHealth() -> Int
    {
        return self.health
    }
    
    func getSelectedWeaponDamage() -> Int{
        return self.weaponsDelegate[selectedWeapon].getDamage()
    }
    
    //for healing
    func increaseHealth(){
        if(self.getHealth() < 100){
            if(self.isAlive()){
                if (self.getHealth() == 99){
                    
                    do {
                         try self.setHealth(health: Player.MAX_HEALTH)
                    }catch PlayerError.healthGraterThanDefaultExcepcion(let msg){
                        print(msg)
                    }catch{
                        print("Error setting health")
                    }
                } else {
                    
                    do {
                         try self.setHealth(health: (self.getHealth()+Player.HEALTH_INCREASE_BY))
                    }catch PlayerError.healthGraterThanDefaultExcepcion(let msg){
                        print(msg)
                    }catch{
                        print("Error setting health")
                    }
                    
                    
                }
            }
        }
    }
    
    func attack(otherPlayer : Player){
        let thisPlayerDamage : Int = self.getSelectedWeaponDamage()
        let otherPlayerDamage : Int = otherPlayer.getSelectedWeaponDamage()
        
        //Function type
        let fDodge:()->Bool = dodge
        
        // this player attacks
        if fDodge() {
            if otherPlayer.isAlive(){
                
                do {
                     try otherPlayer.setHealth(health: otherPlayer.getHealth() - thisPlayerDamage)
                }catch PlayerError.healthGraterThanDefaultExcepcion(let msg){
                    print(msg)
                }catch{
                    print("Error setting health")
                }
            }
        }
        
        // other player attacks
        if fDodge() {
            if self.isAlive(){
                
                do {
                     try self.setHealth(health: self.getHealth() - otherPlayerDamage)
                }catch PlayerError.healthGraterThanDefaultExcepcion(let msg){
                    print(msg)
                }catch{
                    print("Error setting health")
                }
            }
        }
        
        if !self.isAlive() {
            print("\(self.getName()) is dead")
        }
        
        if !otherPlayer.isAlive() {
            print("\(otherPlayer.getName()) is dead")
        }
        
  
    }
        
    func upgradeWeapon(){
        if(self.getSelectedWeapon() < (weaponsDelegate.count - 1))
        {
            self.setSelectedWeapon(selectedWeapon: (self.getSelectedWeapon() + 1) )
            print("Player \(self.getName()) has upgraded his weapon to \(weaponsDelegate[selectedWeapon].getName()).")
        }
    }
    
    // check if the player dodge when he is under attack
    func dodge() -> Bool
    {
        return  Bool.random()
        //return false
    }
    
}

enum PlayerError:Error{
    case healthGraterThanDefaultExcepcion(String)
}
