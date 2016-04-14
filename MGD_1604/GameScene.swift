// Samuel Hubbard
// MGD - 1604
// Game Project (Game currently has no name)
// Current Version: Alpha

/*
 
 Current Artistic Credits:
 All resources pulled from OpenGameArt.org
 
 SciFi Vehicle Sound: Ogrebane
 Voices from Alien Ships: PrettyLobster
 Alien Ships: C-TOY
 Mech: CruzR
 Background Image: cptx032
 Ship Explosion Sound: Luke.RUSTLTD
 Missed Explosion Sound: NenadSimic
 
*/

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // setting up the contact barrier masks with bits
    let barrierMask:UInt32 = 0x1 << 0
    let projectileMask:UInt32 = 0x1 << 1
    let enemyMask:UInt32 = 0x1 << 2
    
    // define the sprite nodes from the scene that require manipulation
    var enemyTypeOne:SKSpriteNode!
    var enemyTypeTwo:SKSpriteNode!
    var playerMech:SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // preload the sound effects
        // this WILL be moved to a different scene later in development.
        do {
            // instantiate the arrays that will hold all of the game's sound effects
            let wavs = ["mech", "EnemyExplosionSound", "MissExplosion", "ProjectileFired"]
            let mp3s = ["alien"]
            
            // run a for loop that will preload all of the sound effects for wav files
            for wav in wavs {
                let wavPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(wav, ofType: "wav")!))
                wavPlayer.prepareToPlay()
            }
            
            // run a for loop that will preload all of the sound effects for mp3 files
            for mp3 in mp3s {
                let mp3Player = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(mp3, ofType: "mp3")!))
                mp3Player.prepareToPlay()
            }
        } catch {
            
        }
        
        // setting the contactDelegate (for collisions) to self
        self.physicsWorld.contactDelegate = self
        
        // link the variables to the sprite notes in the scene
        enemyTypeOne = self.childNodeWithName("enemyOne") as! SKSpriteNode
        enemyTypeTwo = self.childNodeWithName("enemyTwo") as! SKSpriteNode
        playerMech = self.childNodeWithName("mech") as! SKSpriteNode
        
        // create the first animation for the first half of the patrol for enemy 1
        let enemyOnePatrolOne = SKAction.moveByX(-1805.0, y: 0.0, duration: 4.0)
        // set the timing mode for the first half of the animation
        enemyOnePatrolOne.timingMode = .EaseInEaseOut
        
        // create the second animation for the second half of the patrol for enemy 1
        let enemyOnePatrolTwo = SKAction.moveByX(1805.0, y: 0.0, duration: 4.0)
        // set the timing mode for the second half of the animation
        enemyOnePatrolTwo.timingMode = .EaseInEaseOut
        
        // create the sequence for enemy 1's patrol animation, assign it to the sprite and run forever
        let enemyOneSequence = SKAction.sequence([enemyOnePatrolOne, enemyOnePatrolTwo])
        enemyTypeOne.runAction(SKAction.repeatActionForever(enemyOneSequence))
        
        // create the first animation for the first half of the patrol for enemy 2
        let enemyTwoPatrolOne = SKAction.moveByX(1805.0, y: 0.0, duration: 5.0)
        // set the timing mode for the first half of the animation
        enemyTwoPatrolOne.timingMode = .EaseInEaseOut
        
        // create the second animation for the second half of the patrol for enemy 2
        let enemyTwoPatrolTwo = SKAction.moveByX(-1805.0, y: 0.0, duration: 5.0)
        // set the timing mode for the second half of the animation
        enemyTwoPatrolTwo.timingMode = .EaseInEaseOut
        
        // create the sequence for enemy 2's patrol animation, assign it to the sprite and run forever
        let enemyTwoSequence = SKAction.sequence([enemyTwoPatrolOne, enemyTwoPatrolTwo])
        enemyTypeTwo.runAction(SKAction.repeatActionForever(enemyTwoSequence))
 
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        // set a constant to the projectile sprite located in a different scene
        let projectile:SKSpriteNode = SKScene(fileNamed: "Projectile")!.childNodeWithName("projectile")! as! SKSpriteNode
        
        // play the sound for firing a projectile
        self.runAction(SKAction.playSoundFileNamed("ProjectileFired.wav", waitForCompletion: true))
        
        // remove the projectile from it's current parent and add it to this scene
        projectile.removeFromParent()
        self.addChild(projectile)
        
        // set the projectile's position and z on screen
        projectile.position = playerMech.position
        projectile.zPosition = 1
        
        // shoot the projectile out
        projectile.physicsBody?.applyImpulse(CGVectorMake(90.0, 190.0))
        
        // set the collision bit mask and contact test bit mask for the projectile
        projectile.physicsBody?.collisionBitMask = barrierMask | enemyMask
        projectile.physicsBody?.contactTestBitMask = projectile.physicsBody!.collisionBitMask

    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // run a for loop for the touch
        for touch:AnyObject! in touches {
            // get the location of the touch
            let touchLocation = touch.locationInNode(self)
            
            // set a variable that holds what sprite was touched
            let touchedSprite = self.nodeAtPoint(touchLocation)
            
            // set a variable that holds the name of the touched sprite
            let spriteName = touchedSprite.name
            
            // run a conditional statement that handles all actions required for a touched sprite by name
            if spriteName == "enemyOne" {
                self.runAction(SKAction.playSoundFileNamed("alien.mp3", waitForCompletion: true))
            } else if spriteName == "enemyTwo" {
                self.runAction(SKAction.playSoundFileNamed("alien.mp3", waitForCompletion: true))
            } else if spriteName == "mech" {
                self.runAction(SKAction.playSoundFileNamed("mech.wav", waitForCompletion: true))
            }
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    // for when a collision has been detected
    func didBeginContact(contact: SKPhysicsContact) {
        // set a constant and detect which element was the projectile
        let projectile = (contact.bodyA.categoryBitMask == projectileMask) ? contact.bodyA : contact.bodyB
        
        // set a constant to what the projectile collided with
        let collidedWith = (projectile == contact.bodyA) ? contact.bodyB : contact.bodyA
        
        // if the projectile collided with an enemy ship
        if collidedWith.categoryBitMask == enemyMask {
            // instantiate the enemy explosion particle effect
            let enemyExplosion:SKEmitterNode = SKEmitterNode(fileNamed: "EnemyExplosion")!
            
            // set the ship explosion particle effect position and z
            enemyExplosion.position = collidedWith.node!.position
            enemyExplosion.zPosition = 2
            
            // add the ship explosion effect to the screen
            self.addChild(enemyExplosion)
            
            // instantiate the projectile explosion particle effect
            let projectileExplosion:SKEmitterNode = SKEmitterNode(fileNamed: "ProjectileExplosion")!
            
            // set the projectile explosion's position (to the contact point) and z
            projectileExplosion.position = contact.contactPoint
            projectileExplosion.zPosition = 2
            
            // add the projectile explosion to the screen
            self.addChild(projectileExplosion)
            
            // play the ship explosion sound
            self.runAction(SKAction.playSoundFileNamed("EnemyExplosionSound.wav", waitForCompletion: true))
            
            // remove both the projectile and ship from the screen
            collidedWith.node?.removeFromParent()
            projectile.node?.removeFromParent()
            
        } else if collidedWith.categoryBitMask == barrierMask { // if the projectile missed and ended up hitting the ground
            // instantiate the projectile explosion particle effect
            let projectileExplosion:SKEmitterNode = SKEmitterNode(fileNamed: "ProjectileExplosion")!
            
            // set the explosion's position and z
            projectileExplosion.position = contact.contactPoint
            projectileExplosion.zPosition = 2
            
            // add the explosion effect to the screen
            self.addChild(projectileExplosion)
            
            // play the missed explosion sound
            self.runAction(SKAction.playSoundFileNamed("MissExplosion.wav", waitForCompletion: true))
            
            // remove the projectile from the screen
            projectile.node?.removeFromParent()
        }
    }
}
