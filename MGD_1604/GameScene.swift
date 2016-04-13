// Samuel Hubbard
// MGD - 1604
// Game Project (Game currently has no name)
// Current Version: Proof

/*
 
 Current Artistic Credits:
 All resources pulled from OpenGameArt.org
 
 SciFi Vehicle Sound: Ogrebane
 Voices from Alien Ships: PrettyLobster
 Alien Ships: C-TOY
 Mech: CruzR
 Background Image: cptx032
 
*/

import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    // define the sprite nodes from the scene that require manipulation
    var enemyTypeOne:SKSpriteNode!
    var enemyTypeTwo:SKSpriteNode!
    var playerMech:SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // preload the sound effects
        do {
            // instantiate the arrays that will hold all of the game's sound effects
            let wavs = ["mech"]
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
        
        // link the variables to the sprite notes in the scene
        enemyTypeOne = self.childNodeWithName("enemyOne") as! SKSpriteNode
        enemyTypeTwo = self.childNodeWithName("enemyTwo") as! SKSpriteNode
        playerMech = self.childNodeWithName("mech") as! SKSpriteNode
        
        let enemyOnePatrolOne = SKAction.moveByX(-1805.0, y: 0.0, duration: 4.0)
        enemyOnePatrolOne.timingMode = .EaseInEaseOut
        let enemyOnePatrolTwo = SKAction.moveByX(1805.0, y: 0.0, duration: 4.0)
        enemyOnePatrolTwo.timingMode = .EaseInEaseOut
        let enemyOneSequence = SKAction.sequence([enemyOnePatrolOne, enemyOnePatrolTwo])
        enemyTypeOne.runAction(SKAction.repeatActionForever(enemyOneSequence))
        
        let enemyTwoPatrolOne = SKAction.moveByX(1805.0, y: 0.0, duration: 5.0)
        enemyTwoPatrolOne.timingMode = .EaseInEaseOut
        let enemyTwoPatrolTwo = SKAction.moveByX(-1805.0, y: 0.0, duration: 5.0)
        enemyTwoPatrolTwo.timingMode = .EaseInEaseOut
        let enemyTwoSequence = SKAction.sequence([enemyTwoPatrolOne, enemyTwoPatrolTwo])
        enemyTypeTwo.runAction(SKAction.repeatActionForever(enemyTwoSequence))
 
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */

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
}
