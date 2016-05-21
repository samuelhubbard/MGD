// Samuel Hubbard
// MGD - 1604 & IAD - 1605
// Final Hope
// Current Version: Gold

import SpriteKit

class MainMenuScene: SKScene {
    // define all of the sprite nodes on the main menu
    var startButton:SKLabelNode = SKLabelNode()
    var instructionsButton:SKLabelNode = SKLabelNode()
    var creditsButton:SKLabelNode = SKLabelNode()
    var leaderboardButton:SKLabelNode = SKLabelNode()
    var levelSelection:SKLabelNode = SKLabelNode()
    
    let apiKey = "0f3f60f530c7a19aaea37ec9d09283c2f3908fe541aa26f946d839141432a80d"
    let secretKey = "14487c8ed6ffd81b863c957150217752b85ad0e81d7321d658d471b880fbd472"
    
    override func didMoveToView(view: SKView) {
        // link the sprite nodes to the storyboard
        startButton = self.childNodeWithName("startButton") as! SKLabelNode
        instructionsButton = self.childNodeWithName("instructionsButton") as! SKLabelNode
        creditsButton = self.childNodeWithName("creditsButton") as! SKLabelNode
        leaderboardButton = self.childNodeWithName("leaderboardButton") as! SKLabelNode
        levelSelection = self.childNodeWithName("levelSelection") as! SKLabelNode

    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // locate the touch
        for touch:AnyObject! in touches {
            // set where the touch happened
            let touchLocation = touch.locationInNode(self)
            
            // get what sprite was touched
            let touchedSprite = self.nodeAtPoint(touchLocation)
            
            // get the touched sprite's name
            let spriteName = touchedSprite.name
            
            // conditional statment to load into other scenes based on the chosen sprite
            if spriteName == "startButton" {
                // set the scene that will be transitioned into
                let gameMode:GameScene = GameScene(fileNamed: "GameScene")!
                
                // add the required definitions (scaleMode and the transition animation)
                gameMode.scaleMode = .Fill
                let transitionToScene:SKTransition = SKTransition.crossFadeWithDuration(2.0)
                
                // perform the transition
                self.view?.presentScene(gameMode, transition: transitionToScene)
            } else if spriteName == "instructionsButton" {
                // set the scene that will be transitioned into
                let instructionsScene:InstructionsScene = InstructionsScene(fileNamed: "InstructionsScene")!
                
                // add the required definitions (scaleMode and the transition animation)
                instructionsScene.scaleMode = .Fill
                let transitionToScene:SKTransition = SKTransition.crossFadeWithDuration(1.0)
                
                // perform the transition
                self.view?.presentScene(instructionsScene, transition: transitionToScene)
            } else if spriteName == "creditsButton" {
                // set the scene that will be transitioned into
                let creditsScene:CreditsScene = CreditsScene(fileNamed: "CreditsScene")!
                
                // add the required definitions (scaleMode and the transition animation)
                creditsScene.scaleMode = .Fill
                let transitionToScene:SKTransition = SKTransition.crossFadeWithDuration(1.0)
                
                // perform the transition
                self.view?.presentScene(creditsScene, transition: transitionToScene)
            } else if spriteName == "leaderboardButton" {
                // set the scene that will be transitioned into
                let leaderboardScene:LeaderboardScene = LeaderboardScene(fileNamed: "LeaderboardScene")!
                
                // add the required definitions (scaleMode and the transition animation)
                leaderboardScene.scaleMode = .Fill
                let transitionToScene:SKTransition = SKTransition.crossFadeWithDuration(1.0)
                
                // perform the transition
                self.view?.presentScene(leaderboardScene, transition: transitionToScene)
            } else if spriteName == "levelSelection" {
                // set the scene that will be transitioned into
                let levelSelectionScene:LevelSelection = LevelSelection(fileNamed: "LevelSelection")!
                
                // add the required definitions (scaleMode and the transition animation)
                levelSelectionScene.scaleMode = .Fill
                let transitionToScene:SKTransition = SKTransition.crossFadeWithDuration(1.0)
                
                // perform the transition
                self.view?.presentScene(levelSelectionScene, transition: transitionToScene)
            }
        }
    }
}
