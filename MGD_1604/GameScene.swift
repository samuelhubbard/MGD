// Samuel Hubbard
// MGD - 1604
// Final Hope
// Current Version: Beta

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
 Projectile Fired Sound: bart
 End Game Explosion Animation: helpcomputer
 End Game Explosion Sound: Bart K.
 End Game Conditions Sound: Brandon Morris
 
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
    var enemyTypeThree:SKSpriteNode!
    var playerMech:SKSpriteNode!
    var pauseButton:SKSpriteNode!
    var fireButton:SKSpriteNode!
    var roundContainer:SKSpriteNode!
    var roundCounter:SKLabelNode!
    var explosion:SKSpriteNode!
    var explosionTextureAtlas = SKTextureAtlas()
    var explosionTextureArray = [SKTexture]()
    var winConditionsLabel = SKLabelNode()
    
    
    // boolean that tells whether to pause or unpause the scene.
    var gamePaused:Bool = false
    
    // game conditions
    var gameComplete:Bool = false
    var enemiesArray:[String]!
    var projectilesInAir:Int = 0
    var totalNumberOfProjectiles = 5
    var wonGame:Bool = false
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // preload the sound effects
        // this WILL be moved to a different scene later in development.
        do {
            // instantiate the arrays that will hold all of the game's sound effects
            let wavs = ["mech", "EnemyExplosionSound", "MissExplosion", "ProjectileFired", "EndGame"]
            let mp3s = ["alien", "EndConditions"]
            
            // run a for loop that will preload all of the sound effects for wav files
            for wav in wavs {
                let wavPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(wav, ofType: "wav")!))
                wavPlayer.prepareToPlay()
            }
            
            // run a for loop that will preload all of the sound effects for mp3 files
            // even though there is only one, there may be another mp3 added later in development, so... FUTURECASTING!
            for mp3 in mp3s {
                let mp3Player = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(mp3, ofType: "mp3")!))
                mp3Player.prepareToPlay()
            }
        } catch {
            
        }
        
        // setting the contactDelegate (for collisions) to self
        self.physicsWorld.contactDelegate = self
        
        // link the variables to the sprite nodes in the scene
        enemyTypeOne = self.childNodeWithName("enemyOne") as! SKSpriteNode
        enemyTypeTwo = self.childNodeWithName("enemyTwo") as! SKSpriteNode
        enemyTypeThree = self.childNodeWithName("enemyThree") as! SKSpriteNode
        playerMech = self.childNodeWithName("mech") as! SKSpriteNode
        pauseButton = self.childNodeWithName("pauseButton") as! SKSpriteNode
        fireButton = self.childNodeWithName("fireButton") as! SKSpriteNode
        roundContainer = self.childNodeWithName("roundContainer") as! SKSpriteNode
        roundCounter = roundContainer.childNodeWithName("totalRounds") as! SKLabelNode
        
        // instantiating the array that will hold the names of all of the enemy sprites
        enemiesArray = []
        
        // looping through all of the sprite nodes in the scene and populating the array with enemy sprite names
        for child in self.children {
            let spriteNode = child as? SKSpriteNode
            if spriteNode!.physicsBody?.categoryBitMask == enemyMask {
                enemiesArray.append(spriteNode!.name!)
            }
        }
        
        // setting how many rounds the user to fire on the screen
        roundCounter.text = String(totalNumberOfProjectiles)
        
        // linking to the texture atlas
        explosionTextureAtlas = SKTextureAtlas(named: "Explosion")
                
        // looping through the array to 
        for i in 1...explosionTextureAtlas.textureNames.count {
            let textureName = "explosion\(i).png"
            explosionTextureArray.append(SKTexture(imageNamed: textureName))
        }
        
        // defining the end of game coditions label and adding it to the screen
        winConditionsLabel = SKLabelNode(fontNamed: "Futura")
        winConditionsLabel.text = "Conditions"
        winConditionsLabel.fontSize = 96
        winConditionsLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        winConditionsLabel.zPosition = 4
        winConditionsLabel.alpha = 0
        self.addChild(winConditionsLabel)
        
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
        enemyTypeOne.runAction(SKAction.repeatActionForever(enemyOneSequence), withKey: "e1KeyAnimation")
        
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
        enemyTypeTwo.runAction(SKAction.repeatActionForever(enemyTwoSequence), withKey: "e2KeyAnimation")
        
        // create the first animation for the first half of the patrol for enemy 3
        let enemyThreePatrolOne = SKAction.moveByX(-1805.0, y: 0.0, duration: 2.5)
        // set the timing mode for the first half of the animation
        enemyOnePatrolOne.timingMode = .EaseInEaseOut
        
        // create the second animation for the second half of the patrol for enemy 3
        let enemyThreePatrolTwo = SKAction.moveByX(1805.0, y: 0.0, duration: 2.5)
        // set the timing mode for the second half of the animation
        enemyOnePatrolTwo.timingMode = .EaseInEaseOut
        
        // create the sequence for enemy 3's patrol animation, assign it to the sprite and run forever
        let enemyThreeSequence = SKAction.sequence([enemyThreePatrolOne, enemyThreePatrolTwo])
        enemyTypeThree.runAction(SKAction.repeatActionForever(enemyThreeSequence), withKey: "e3KeyAnimation")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        // run a for loop for the touch
        for touch:AnyObject! in touches {
            // get the location of the touch
            let touchLocation = touch.locationInNode(self)
            
            // set a variable that holds what sprite was touched
            let touchedSprite = self.nodeAtPoint(touchLocation)
            
            // set a variable that holds the name of the touched sprite
            let spriteName = touchedSprite.name
            
            // run a conditional statement that handles all actions required for a touched sprite by name
            // ensures that the game is not paused for all applicable touches
            if spriteName == "enemyOne" {
                if gamePaused == false {
                    self.runAction(SKAction.playSoundFileNamed("alien.mp3", waitForCompletion: true))
                }
            } else if spriteName == "enemyTwo" {
                if gamePaused == false {
                    self.runAction(SKAction.playSoundFileNamed("alien.mp3", waitForCompletion: true))
                }
            } else if spriteName == "mech" {
                if gamePaused == false {
                    self.runAction(SKAction.playSoundFileNamed("mech.wav", waitForCompletion: true))
                }
            // if the pause button was hit
            } else if spriteName == "pauseButton" {
                // if the game is not currently paused
                if gamePaused == false {
                    // pause it and set the boolean to indicate the game is now paused
                    scene!.view!.paused = true
                    gamePaused = true
                // if the game is currently paused
                } else if gamePaused == true {
                    // "unpause" it and set the boolean to indicate the game is now "unpaused"
                    scene!.view!.paused = false
                    gamePaused = false
                }
            // if none of sprites listed above were touched, fire a projectile!
            } else if spriteName == "fireButton" {
                if gamePaused == false && totalNumberOfProjectiles > 0 {
                    
                    // adjusting the total amount of rounds left to the user and tracking projectiles in air
                    totalNumberOfProjectiles -= 1
                    projectilesInAir += 1
                    
                    // TODO: Update GUI
                    roundCounter.text = String(totalNumberOfProjectiles)
                    
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
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // checking win conditions
        if !gameComplete {
            if enemiesArray.isEmpty {
                wonGame = true
                self.animateExplosion()
                gameComplete = true
            }
            
            // just incase of an error
            else if !enemiesArray.isEmpty && totalNumberOfProjectiles == 0 && projectilesInAir == 0 {
                wonGame = false
                self.animateExplosion()
                gameComplete = true
            }
        }
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
            
            // this code block is primarily used for more accurate game progress tracking
            for enemy in enemiesArray {
                // finds the enemy that was hit
                if enemy == collidedWith.node?.name {
                    // projectile tracking
                    projectilesInAir -= 1
                    
                    // sets the index path for removal from the array
                    // (tracking how many enemies are left is done through the count of this array
                    let removalIndex = enemiesArray.indexOf(enemy)!
                    enemiesArray.removeAtIndex(removalIndex)
                }
            }
            
            // remove both the projectile and ship from the screen
            collidedWith.node?.removeFromParent()
            projectile.node?.removeFromParent()
            
            
        } else if collidedWith.categoryBitMask == barrierMask { // if the projectile missed and ended up hitting the ground
            // instantiate the projectile explosion particle effect
            let projectileExplosion:SKEmitterNode = SKEmitterNode(fileNamed: "ProjectileExplosion")!
            
            // projectile in air tracking
            projectilesInAir -= 1
            
            // set the explosion's position and z
            projectileExplosion.position = contact.contactPoint
            projectileExplosion.zPosition = 2
            
            // add the explosion effect to the screen
            self.addChild(projectileExplosion)
            
            // play the missed explosion sound
            self.runAction(SKAction.playSoundFileNamed("MissExplosion.wav", waitForCompletion: true))
            
            // remove the projectile from the screen
            projectile.node?.removeFromParent()
            
            // checking loss conditions
            if !gameComplete {
                if enemiesArray.count > 0 && totalNumberOfProjectiles == 0 && projectilesInAir == 0{
                    wonGame = false
                    self.animateExplosion()
                    gameComplete = true
                }
            }
        }
    }
    
    func animateExplosion() {
        // start off the explosion with... WAITING!
        let wait = SKAction.waitForDuration(2)
        
        // defining the explosion parameters
        explosion = SKSpriteNode(imageNamed: "explosion1.png")
        explosion.size = CGSize(width: 425.0, height: 430.0)
        explosion.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        explosion.zPosition = 3
        
        // start the code block for the explosion and label showing
        let startExplosion = SKAction.runBlock {
            // if the game wasn't won
            if !self.wonGame {
                
                // loop through all remaining enemies and stop their animations utilizing action keys
                for enemy in self.enemiesArray {
                    if enemy == "enemyOne" {
                        self.enemyTypeOne.removeActionForKey("e1KeyAnimation")
                    } else if enemy == "enemyTwo" {
                        self.enemyTypeTwo.removeActionForKey("e2KeyAnimation")
                    } else if enemy == "enemyThree" {
                        self.enemyTypeThree.removeActionForKey("e3KeyAnimation")
                    }
                }
            }
            // add the explosion and run the action to show it + play a sound
            self.addChild(self.explosion)
            self.runAction(SKAction.playSoundFileNamed("EndGame.wav", waitForCompletion: true))
            self.explosion.runAction(SKAction.animateWithTextures(self.explosionTextureArray, timePerFrame: 0.1))
            
            // setting up for the label, define the waiting time and code block to show the text
            let moreWaiting = SKAction.waitForDuration(1)
            let showEndCondition = SKAction.runBlock({
                self.explosion.removeFromParent()
                
                // define the text for the label based on the outcome of the game
                if self.wonGame {
                    self.winConditionsLabel.text = "YOU WON!"
                } else {
                    self.winConditionsLabel.text = "YOU LOST!"
                }
                
                // define the action and run it and then a sound through a sequence
                let fade = SKAction.fadeAlphaTo(1, duration: 0.001)
                self.winConditionsLabel.runAction(fade)
                let soundWaiting = SKAction.waitForDuration(0.5)
                let playSound = SKAction.runBlock({ 
                    self.runAction(SKAction.playSoundFileNamed("EndConditions.mp3", waitForCompletion: true))
                })
                self.runAction(SKAction.sequence([soundWaiting, playSound]))
            })
            
            // run the action sequence for the end of game conditions text
            self.runAction(SKAction.sequence([moreWaiting, showEndCondition]))
        }
        // run the action sequence for the explosion
        self.runAction(SKAction.sequence([wait, startExplosion]))
    }
}
