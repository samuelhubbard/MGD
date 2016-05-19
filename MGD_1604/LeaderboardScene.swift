// Samuel Hubbard
// MGD - 1604 & IAD - 1605
// Final Hope
// Current Version: Gold

import SpriteKit

class LeaderboardScene:SKScene {
    var backToMainMenuButton:SKLabelNode = SKLabelNode()
    var levelOneLeaderboardButton:SKLabelNode = SKLabelNode()
    var levelTwoLeaderboardButton:SKLabelNode = SKLabelNode()
    var levelThreeLeaderboardButton:SKLabelNode = SKLabelNode()
    
    // leaderboard box and associated label nodes
    var leaderboardBox:SKSpriteNode = SKSpriteNode()
    var nameOne:SKLabelNode = SKLabelNode()
    var nameTwo:SKLabelNode = SKLabelNode()
    var nameThree:SKLabelNode = SKLabelNode()
    var nameFour:SKLabelNode = SKLabelNode()
    var nameFive:SKLabelNode = SKLabelNode()
    var scoreOne:SKLabelNode = SKLabelNode()
    var scoreTwo:SKLabelNode = SKLabelNode()
    var scoreThree:SKLabelNode = SKLabelNode()
    var scoreFour:SKLabelNode = SKLabelNode()
    var scoreFive:SKLabelNode = SKLabelNode()
    
    // all the stars in the leaderboard box
    var scoreOneStarOne:SKSpriteNode = SKSpriteNode()
    var scoreOneStarTwo:SKSpriteNode = SKSpriteNode()
    var scoreOneStarThree:SKSpriteNode = SKSpriteNode()
    var scoreTwoStarOne:SKSpriteNode = SKSpriteNode()
    var scoreTwoStarTwo:SKSpriteNode = SKSpriteNode()
    var scoreTwoStarThree:SKSpriteNode = SKSpriteNode()
    var scoreThreeStarOne:SKSpriteNode = SKSpriteNode()
    var scoreThreeStarTwo:SKSpriteNode = SKSpriteNode()
    var scoreThreeStarThree:SKSpriteNode = SKSpriteNode()
    var scoreFourStarOne:SKSpriteNode = SKSpriteNode()
    var scoreFourStarTwo:SKSpriteNode = SKSpriteNode()
    var scoreFourStarThree:SKSpriteNode = SKSpriteNode()
    var scoreFiveStarOne:SKSpriteNode = SKSpriteNode()
    var scoreFiveStarTwo:SKSpriteNode = SKSpriteNode()
    var scoreFiveStarThree:SKSpriteNode = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        backToMainMenuButton = self.childNodeWithName("backToMainMenuButton") as! SKLabelNode
        levelOneLeaderboardButton = self.childNodeWithName("levelOneLeaderboardButton") as! SKLabelNode
        levelTwoLeaderboardButton = self.childNodeWithName("levelTwoLeaderboardButton") as! SKLabelNode
        levelThreeLeaderboardButton = self.childNodeWithName("levelThreeLeaderboardButton") as! SKLabelNode
        
        // constant holding the leaderboard box
        leaderboardBox = SKScene(fileNamed: "LeaderboardTemplateScene")!.childNodeWithName("leaderboardBox")! as! SKSpriteNode
        
        // remove the leaderboard box from it's current parent and add it to this scene
        leaderboardBox.removeFromParent()
        self.addChild(leaderboardBox)
        
        // set the leaderboard box's position and z on screen
        leaderboardBox.position = CGPointMake(self.frame.width / 2, 400)
        leaderboardBox.zPosition = 2
        
        // linking the names
        nameOne = leaderboardBox.childNodeWithName("nameOne") as! SKLabelNode
        nameTwo = leaderboardBox.childNodeWithName("nameTwo") as! SKLabelNode
        nameThree = leaderboardBox.childNodeWithName("nameThree") as! SKLabelNode
        nameFour = leaderboardBox.childNodeWithName("nameFour") as! SKLabelNode
        nameFive = leaderboardBox.childNodeWithName("nameFive") as! SKLabelNode
        
        // linking the scores
        scoreOne = leaderboardBox.childNodeWithName("scoreOne") as! SKLabelNode
        scoreTwo = leaderboardBox.childNodeWithName("scoreTwo") as! SKLabelNode
        scoreThree = leaderboardBox.childNodeWithName("scoreThree") as! SKLabelNode
        scoreFour = leaderboardBox.childNodeWithName("scoreFour") as! SKLabelNode
        scoreFive = leaderboardBox.childNodeWithName("scoreFive") as! SKLabelNode
        
        // linking the stars
        scoreOneStarOne = leaderboardBox.childNodeWithName("scoreOneStarOne") as! SKSpriteNode
        scoreOneStarTwo = leaderboardBox.childNodeWithName("scoreOneStarTwo") as! SKSpriteNode
        scoreOneStarThree = leaderboardBox.childNodeWithName("scoreOneStarThree") as! SKSpriteNode
        scoreTwoStarOne = leaderboardBox.childNodeWithName("scoreTwoStarOne") as! SKSpriteNode
        scoreTwoStarTwo = leaderboardBox.childNodeWithName("scoreTwoStarTwo") as! SKSpriteNode
        scoreTwoStarThree = leaderboardBox.childNodeWithName("scoreTwoStarThree") as! SKSpriteNode
        scoreThreeStarOne = leaderboardBox.childNodeWithName("scoreThreeStarOne") as! SKSpriteNode
        scoreThreeStarTwo = leaderboardBox.childNodeWithName("scoreThreeStarTwo") as! SKSpriteNode
        scoreThreeStarThree = leaderboardBox.childNodeWithName("scoreThreeStarThree") as! SKSpriteNode
        scoreFourStarOne = leaderboardBox.childNodeWithName("scoreFourStarOne") as! SKSpriteNode
        scoreFourStarTwo = leaderboardBox.childNodeWithName("scoreFourStarTwo") as! SKSpriteNode
        scoreFourStarThree = leaderboardBox.childNodeWithName("scoreFourStarThree") as! SKSpriteNode
        scoreFiveStarOne = leaderboardBox.childNodeWithName("scoreFiveStarOne") as! SKSpriteNode
        scoreFiveStarTwo = leaderboardBox.childNodeWithName("scoreFiveStarTwo") as! SKSpriteNode
        scoreFiveStarThree = leaderboardBox.childNodeWithName("scoreFiveStarThree") as! SKSpriteNode
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch:AnyObject! in touches {
            // set where the touch happened
            let touchLocation = touch.locationInNode(self)
            
            // get what sprite was touched
            let touchedSprite = self.nodeAtPoint(touchLocation)
            
            // get the touched sprite's name
            let spriteName = touchedSprite.name
            
            // conditional statment to load into other scenes based on the chosen sprite
            if spriteName == "backToMainMenuButton" {
                // upon touch, load back into the main menu
                let mainMenu = MainMenuScene(fileNamed: "MainMenuScene")!
                
                mainMenu.scaleMode = .Fill
                let transitionToScene:SKTransition = SKTransition.crossFadeWithDuration(1.0)
                
                self.view?.presentScene(mainMenu, transition: transitionToScene)
            } else if spriteName == "levelOneLeaderboardButton" {
                // show level one leaderboard
            } else if spriteName == "levelTwoLeaderboardButton" {
                // show level two leaderboard
            } else if spriteName == "levelThreeLeaderboardButton" {
                // show level three leaderboard
            }
        }
    }
}
