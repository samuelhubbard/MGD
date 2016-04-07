// Samuel Hubbard
// MGD - 1604
// Game Project (Game currently has no name)

import SpriteKit

class GameScene: SKScene {
    
    var enemyTypeOne:SKSpriteNode!
    var enemyTypeTwo:SKSpriteNode!
    var playerMech:SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        enemyTypeOne = self.childNodeWithName("enemyOne") as! SKSpriteNode
        enemyTypeTwo = self.childNodeWithName("enemyTwo") as! SKSpriteNode
        playerMech = self.childNodeWithName("mech") as! SKSpriteNode
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */

    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch:AnyObject! in touches {
            let touchLocation = touch.locationInNode(self)
            
            let touchedSprite = self.nodeAtPoint(touchLocation)
            
            let spriteName = touchedSprite.name
            
            if spriteName == "enemyOne" {
                print("Enemy clicked")
            } else if spriteName == "enemyTwo" {
                print("The other enemy was clicked")
            } else if spriteName == "mech" {
                print("The player was clicked")
            }
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
