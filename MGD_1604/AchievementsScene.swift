// Samuel Hubbard
// MGD - 1604 & IAD - 1605
// Final Hope
// Current Version: Gold

import SpriteKit

class AchievementsScene: SKScene {
    // instantiating
    var backToMainMenuButton:SKLabelNode = SKLabelNode()
    var boxOne:SKSpriteNode = SKSpriteNode()
    var boxTwo:SKSpriteNode = SKSpriteNode()
    var boxThree:SKSpriteNode = SKSpriteNode()
    var boxFour:SKSpriteNode = SKSpriteNode()
    
    var achievementNameOne:SKLabelNode = SKLabelNode()
    var achievementNameTwo:SKLabelNode = SKLabelNode()
    var achievementNameThree:SKLabelNode = SKLabelNode()
    var achievementNameFour:SKLabelNode = SKLabelNode()
    
    var achievementDescOne:SKLabelNode = SKLabelNode()
    var achievementDescTwo:SKLabelNode = SKLabelNode()
    var achievementDescThree:SKLabelNode = SKLabelNode()
    var achievementDescFour:SKLabelNode = SKLabelNode()
    
    var achievementDateOne:SKLabelNode = SKLabelNode()
    var achievementDateTwo:SKLabelNode = SKLabelNode()
    var achievementDateThree:SKLabelNode = SKLabelNode()
    var achievementDateFour:SKLabelNode = SKLabelNode()
    
    // BaaS access information
    let apiKey = "0f3f60f530c7a19aaea37ec9d09283c2f3908fe541aa26f946d839141432a80d"
    let secretKey = "14487c8ed6ffd81b863c957150217752b85ad0e81d7321d658d471b880fbd472"
    let userName = "Sam"

    // achievement collection array
    var achievementCollection:[AchievementsCollection] = []
    
    override func didMoveToView(view: SKView) {
        // linking to the scene
        backToMainMenuButton = self.childNodeWithName("backToMainMenuButton") as! SKLabelNode
        boxOne = self.childNodeWithName("boxOne") as! SKSpriteNode
        boxTwo = self.childNodeWithName("boxTwo") as! SKSpriteNode
        boxThree = self.childNodeWithName("boxThree") as! SKSpriteNode
        boxFour = self.childNodeWithName("boxFour") as! SKSpriteNode
        
        achievementNameOne = boxOne.childNodeWithName("achievementName") as! SKLabelNode
        achievementNameTwo = boxTwo.childNodeWithName("achievementName") as! SKLabelNode
        achievementNameThree = boxThree.childNodeWithName("achievementName") as! SKLabelNode
        achievementNameFour = boxFour.childNodeWithName("achievementName") as! SKLabelNode
        
        achievementDescOne = boxOne.childNodeWithName("achievementDesc") as! SKLabelNode
        achievementDescTwo = boxTwo.childNodeWithName("achievementDesc") as! SKLabelNode
        achievementDescThree = boxThree.childNodeWithName("achievementDesc") as! SKLabelNode
        achievementDescFour = boxFour.childNodeWithName("achievementDesc") as! SKLabelNode
        
        achievementDateOne = boxOne.childNodeWithName("achievementDate") as! SKLabelNode
        achievementDateTwo = boxTwo.childNodeWithName("achievementDate") as! SKLabelNode
        achievementDateThree = boxThree.childNodeWithName("achievementDate") as! SKLabelNode
        achievementDateFour = boxFour.childNodeWithName("achievementDate") as! SKLabelNode
        
        // setting the alpha for the boxes
        boxOne.alpha = 0
        boxTwo.alpha = 0
        boxThree.alpha = 0
        boxFour.alpha = 0
        
        let userName = self.userName
        App42API.initializeWithAPIKey(self.apiKey, andSecretKey:self.secretKey)
        let achievementService = App42API.buildAchievementService() as? AchievementService
        achievementService?.getAllAchievementsForUser(userName, completionBlock:{ (success, response, exception) -> Void in
            if(success)
            {
                let achievements = response as! [Achievement]
                for achievement in achievements{
                    
                    let toArray:AchievementsCollection = AchievementsCollection(_achievement: achievement.name, _description: achievement.description, _date: achievement.achievedOn)
                    
                    self.achievementCollection.append(toArray)
                }
                
                // call the function to sift through the achievements
                
                let wait:SKAction = SKAction.waitForDuration(1.5)
                let run:SKAction = SKAction.runBlock({ 
                    self.displayAchievements(self.achievementCollection)
                })
                self.runAction(SKAction.sequence([wait, run]))
            }
            else
            {
                NSLog("Exception = %@", exception.reason!)
                NSLog("App Error Code = %d", exception.appErrorCode)
                NSLog("HTTP error Code = %d", exception.httpErrorCode)  
                NSLog("User Info = %@", exception.userInfo!)  
            }  
        })
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
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

            }
        }
    }
    
    func displayAchievements(_array:[AchievementsCollection]) {
        //pull in the array
        var array:[AchievementsCollection] = _array
        
        // remove lower incremental achievements from array
        
        // setup the achievement level
        var incrementLevelPosition:Int = 0
        
        // determine what achievement level the user's achievement is at
        for check in array {
            if check.achievementName == "Dedicated" {
                incrementLevelPosition = 3
            } else if check.achievementName == "Definitely Interested" && incrementLevelPosition <= 2 {
                incrementLevelPosition = 2
            } else if check.achievementName == "A Good Start" && incrementLevelPosition <= 1 {
                incrementLevelPosition = 1
            }
        }
        
        // a means to cycle through the array
        var r:Int = 0
        
        // loop through the array and remove all lower tier achievements
        for removal in array {
            if incrementLevelPosition == 3 {
                if removal.achievementName == "Definitely Interested" || removal.achievementName == "A Good Start" {
                    array.removeAtIndex(r)
                    r -= 1
                }
            } else if incrementLevelPosition == 2 {
                if removal.achievementName == "A Good Start" {
                    array.removeAtIndex(r)
                    r -= 1
                }
            }
            
            // increase the number to update what index would need to be removed
            r += 1
        }
        
        // same type of number as above
        var i:Int = 1
        
        // loop through the array and populate/display all earned achievements
        for achievement in array {
            if i == 1 {
                achievementNameOne.text = achievement.achievementName
                achievementDescOne.text = achievement.achievementDescription
                achievementDateOne.text = String(achievement.achievementDate)
                
                boxOne.alpha = 1
            } else if i == 2 {
                achievementNameTwo.text = achievement.achievementName
                achievementDescTwo.text = achievement.achievementDescription
                achievementDateTwo.text = String(achievement.achievementDate)
                
                boxTwo.alpha = 1
            } else if i == 3 {
                achievementNameThree.text = achievement.achievementName
                achievementDescThree.text = achievement.achievementDescription
                achievementDateThree.text = String(achievement.achievementDate)
                
                boxThree.alpha = 1
            } else if i == 4 {
                achievementNameFour.text = achievement.achievementName
                achievementDescFour.text = achievement.achievementDescription
                achievementDateFour.text = String(achievement.achievementDate)
                
                boxFour.alpha = 1
            } else if i > 4 {
                break
            }
            
            // increase the index counter
            i += 1
        }
    }
}
