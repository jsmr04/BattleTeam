class Player{
    
    private static var HEALTH_INCREASE_BY = 2
    private var health: Int
    private var name: String
    var weapons : [Weapon]
    private var selectedWeapon : Int = 0
    private static var MAX_HEALTH : Int = 100
    private static var randomDodge : Bool = false
    private var alive : Bool
    
    // CONSTUCTOR
    init(pName : String , pHealth : Int ){
        self.name = pName
        self.health = pHealth
        self.alive = true
        var tempArray : [Weapon] = [Weapon]()
        let weapon1 = Weapon(gunName : "Pstol", gunDamage: 1 , numBullet:  7 )
        let weapon2 = Weapon(gunName : "Shotgun", gunDamage: 10 , numBullet:  2 )
            
        tempArray.append(weapon1)
        tempArray.append(weapon2)
        self.weapons = tempArray
        self.selectedWeapon = 0
    }
    
    func isAlive() -> Bool{
        var check : Bool = true
        if(self.getHealth() < 1 && self.getHealth() > Player.MAX_HEALTH)
        {
            check = false
        }
        self.setAlive(alive: check)
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
        print("Player\(self.getName()) and Player \(otherPlayer.getName()) are having a FIGHT!!")
        // this player attacks
        if(!dodge()){
            otherPlayer.setHealth(health: otherPlayer.getHealth() - thisPlayerDamage)
            print("Player \(self.getName()) attacked successfully. Player \(otherPlayer.getName())  \(otherPlayer.getHealth()) pts of health remaining.")
        } else{
            print("Player \(otherPlayer.getName()) has dodged the attacked of Player \(self.getName()).")
        }
        // other player attacks
        if(!dodge())
        {
            self.setHealth(health: self.getHealth() - otherPlayerDamage)
            print("Player \(otherPlayer.getName()) attacked successfully. Player \(self.getName())  \(self.getHealth()) pts of health remaining.")
        }
        else
        {
                print("Player \(self.getName()) has dodged the attacked of Player \(otherPlayer.getName()).")
        }
    }
        
    func upgradeWeapon(){
        if(self.getSelectedWeapon() < (weapons.count - 1))
        {
            self.setSelectedWeapon(selectedWeapon: (self.getSelectedWeapon() + 1) )
            print("Player \(self.getName()) has upgraded his weapon to \(weapons[selectedWeapon].getName()).")
        }
    }
    
    // check if the player dodge when he is under attack
    func dodge() -> Bool
    {
        Player.randomDodge = Bool.random()
        return Player.randomDodge
    }
    
}

