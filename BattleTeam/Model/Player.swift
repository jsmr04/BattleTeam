class Player{
    
    private static var HEALTH_INCREASE_BY = 2
    private var health: Int
    private var name: String
    var weapons : [Weapon]
    private var selectedWeapon : Int = 0
    private static var MAX_HEALTH : Int = 100
    private var alive : Bool
    
    // CONSTUCTOR
    init(pName : String , pHealth : Int ){
        self.name = pName
        self.health = pHealth
        self.alive = true
        var tempArray : [Weapon] = [Weapon]()
        let weapon1:Weapon = Weapon(10, "pistol", 10)

            
        tempArray.append(weapon1)

        self.weapons = tempArray
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
    
    func getWeapon() -> [Weapon]{
        return self.weapons
    }
    
    func getSelectedWeapon() -> Int {
        return self.selectedWeapon
    }
    
    func addWeapon(weapon : Weapon) {
        self.weapons.append(weapon)
    }
    
    func setSelectedWeapon(selectedWeapon : Int)
    {
        self.selectedWeapon = selectedWeapon
    }
    
    func setHealth(health : Int)
    {
        self.health = health
    }
    
    func getHealth() -> Int
    {
        return self.health
    }
    
    func getSelectedWeaponDamage() -> Int{
        return self.weapons[selectedWeapon].getDamage()
    }
    
    //for healing
    func increaseHealth(){
        if(self.getHealth() < 100){
            if(self.isAlive()){
                if (self.getHealth() == 99){
                    self.setHealth(health: Player.MAX_HEALTH)
                } else {
                    self.setHealth(health: (self.getHealth()+Player.HEALTH_INCREASE_BY))
                }
            }
        }
    }
    
    func attack(otherPlayer : Player){
        let thisPlayerDamage : Int = self.getSelectedWeaponDamage()
        let otherPlayerDamage : Int = otherPlayer.getSelectedWeaponDamage()
        
        // this player attacks
        if !dodge(){
            if otherPlayer.isAlive(){
                otherPlayer.setHealth(health: otherPlayer.getHealth() - thisPlayerDamage)
            }
        }
        
        // other player attacks
        if !dodge(){
            if self.isAlive(){
                self.setHealth(health: self.getHealth() - otherPlayerDamage)
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
        if(self.getSelectedWeapon() < (weapons.count - 1))
        {
            self.setSelectedWeapon(selectedWeapon: (self.getSelectedWeapon() + 1) )
            //print("Player \(self.getName()) has upgraded his weapon to \(weapons[selectedWeapon].getName()).")
        }
    }
    
    // check if the player dodge when he is under attack
    func dodge() -> Bool
    {
        return  Bool.random()
        //return false
    }
    
}

