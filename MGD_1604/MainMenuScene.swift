// Samuel Hubbard
// MGD - 1604
// Final Hope
// Current Version: Beta

import SpriteKit

class MainMenuScene: SKScene {
    var startButton:SKLabelNode = SKLabelNode()
    var instructionsButton:SKLabelNode = SKLabelNode()
    var creditsButton:SKLabelNode = SKLabelNode()
    
    override func didMoveToView(view: SKView) {
        startButton = self.childNodeWithName("startButton") as! SKLabelNode
        instructionsButton = self.childNodeWithName("instructionsButton") as! SKLabelNode
        creditsButton = self.childNodeWithName("creditsButton") as! SKLabelNode
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch:AnyObject! in touches {
            let touchLocation = touch.locationInNode(self)
            
            let touchedSprite = self.nodeAtPoint(touchLocation)
            
            let spriteName = touchedSprite.name
            
            if spriteName == "startButton" {
                let gameMode:GameScene = GameScene(fileNamed: "GameScene")!
                
                gameMode.scaleMode = .Fill
                let transitionToScene:SKTransition = SKTransition.crossFadeWithDuration(2.0)
                
                self.view?.presentScene(gameMode, transition: transitionToScene)
            } else if spriteName == "instructionsButton" {
                let instructionsScene:InstructionsScene = InstructionsScene(fileNamed: "InstructionsScene")!
                
                instructionsScene.scaleMode = .Fill
                let transitionToScene:SKTransition = SKTransition.crossFadeWithDuration(1.0)
                
                self.view?.presentScene(instructionsScene, transition: transitionToScene)
            } else if spriteName == "creditsButton" {
                let creditsScene:CreditsScene = CreditsScene(fileNamed: "CreditsScene")!
                
                creditsScene.scaleMode = .Fill
                let transitionToScene:SKTransition = SKTransition.crossFadeWithDuration(1.0)
                
                self.view?.presentScene(creditsScene, transition: transitionToScene)
            }
        }
    }
}
