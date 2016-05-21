// Samuel Hubbard
// MGD - 1604 & IAD - 1605
// Final Hope
// Current Version: Gold

import SpriteKit
import FBSDKCoreKit
import FBSDKShareKit

class LeaderboardScene:SKScene {
    // clickable elements from the sks file
    var backToMainMenuButton:SKLabelNode = SKLabelNode()
    var levelOneLeaderboardButton:SKLabelNode = SKLabelNode()
    var levelTwoLeaderboardButton:SKLabelNode = SKLabelNode()
    var levelThreeLeaderboardButton:SKLabelNode = SKLabelNode()
    var globalScoreSelection:SKLabelNode = SKLabelNode()
    var localScoreSelection:SKLabelNode = SKLabelNode()
    var filterTitle:SKLabelNode = SKLabelNode()
    var allStarFilter:SKLabelNode = SKLabelNode()
    var threeStarFilter:SKLabelNode = SKLabelNode()
    var twoStarFilter:SKLabelNode = SKLabelNode()
    var oneStarFilter:SKLabelNode = SKLabelNode()
    var zeroStarFilter:SKLabelNode = SKLabelNode()
    
    // api and secret key for the BaaS
    let apiKey = "0f3f60f530c7a19aaea37ec9d09283c2f3908fe541aa26f946d839141432a80d"
    let secretKey = "14487c8ed6ffd81b863c957150217752b85ad0e81d7321d658d471b880fbd472"
    
    // the game name, score arrays, and button colors
    var gameName = "LevelOne"
    var leaderboardScores:[Score] = []
    var filteredScores:[Score] = []
    var globalSelection:Bool = true
    let selectedColor = UIColor(red: 1.0 / 255, green: 1.0 / 255, blue: 1.0 / 255, alpha: 1.0)
    let unselectedColor = UIColor(red: 255.0 / 255, green: 255.0 / 255, blue: 255.0 / 255, alpha: 1.0)
    
    // leaderboard box and associated label nodes
    var leaderboardBox:SKSpriteNode = SKSpriteNode()
    var name1:SKLabelNode = SKLabelNode()
    var name2:SKLabelNode = SKLabelNode()
    var name3:SKLabelNode = SKLabelNode()
    var name4:SKLabelNode = SKLabelNode()
    var name5:SKLabelNode = SKLabelNode()
    var score1:SKLabelNode = SKLabelNode()
    var score2:SKLabelNode = SKLabelNode()
    var score3:SKLabelNode = SKLabelNode()
    var score4:SKLabelNode = SKLabelNode()
    var score5:SKLabelNode = SKLabelNode()
    
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
    
    let shareButton: FBSDKShareButton = FBSDKShareButton()
    var topScore:Score!
    var shareTopScoreTitle:SKLabelNode = SKLabelNode()
    
    override func didMoveToView(view: SKView) {
        
        // direct scene element linking
        backToMainMenuButton = self.childNodeWithName("backToMainMenuButton") as! SKLabelNode
        levelOneLeaderboardButton = self.childNodeWithName("levelOneLeaderboardButton") as! SKLabelNode
        levelTwoLeaderboardButton = self.childNodeWithName("levelTwoLeaderboardButton") as! SKLabelNode
        levelThreeLeaderboardButton = self.childNodeWithName("levelThreeLeaderboardButton") as! SKLabelNode
        globalScoreSelection = self.childNodeWithName("globalScoreSelection") as! SKLabelNode
        localScoreSelection = self.childNodeWithName("localScoreSelection") as! SKLabelNode
        filterTitle = self.childNodeWithName("filterTitle") as! SKLabelNode
        allStarFilter = self.childNodeWithName("allStarFilter") as! SKLabelNode
        threeStarFilter = self.childNodeWithName("threeStarFilter") as! SKLabelNode
        twoStarFilter = self.childNodeWithName("twoStarFilter") as! SKLabelNode
        oneStarFilter = self.childNodeWithName("oneStarFilter") as! SKLabelNode
        zeroStarFilter = self.childNodeWithName("zeroStarFilter") as! SKLabelNode
        
        // hiding all sub tier buttons
        globalScoreSelection.alpha = 0
        localScoreSelection.alpha = 0
        filterTitle.alpha = 0
        allStarFilter.alpha = 0
        threeStarFilter.alpha = 0
        twoStarFilter.alpha = 0
        oneStarFilter.alpha = 0
        zeroStarFilter.alpha = 0
        
        // constant holding the leaderboard box
        leaderboardBox = SKScene(fileNamed: "LeaderboardTemplateScene")!.childNodeWithName("leaderboardBox")! as! SKSpriteNode
        
        // hiding the leaderboard
        leaderboardBox.alpha = 0
        
        // remove the leaderboard box from it's current parent and add it to this scene
        leaderboardBox.removeFromParent()
        self.addChild(leaderboardBox)
        
        // set the leaderboard box's position and z on screen
        leaderboardBox.position = CGPointMake(self.frame.width / 2, 400)
        leaderboardBox.zPosition = 2
        
        shareTopScoreTitle = leaderboardBox.childNodeWithName("shareTopScoreTitle") as! SKLabelNode
        shareTopScoreTitle.alpha = 0
        
        // linking the names
        name1 = leaderboardBox.childNodeWithName("nameOne") as! SKLabelNode
        name2 = leaderboardBox.childNodeWithName("nameTwo") as! SKLabelNode
        name3 = leaderboardBox.childNodeWithName("nameThree") as! SKLabelNode
        name4 = leaderboardBox.childNodeWithName("nameFour") as! SKLabelNode
        name5 = leaderboardBox.childNodeWithName("nameFive") as! SKLabelNode
        
        // linking the scores
        score1 = leaderboardBox.childNodeWithName("scoreOne") as! SKLabelNode
        score2 = leaderboardBox.childNodeWithName("scoreTwo") as! SKLabelNode
        score3 = leaderboardBox.childNodeWithName("scoreThree") as! SKLabelNode
        score4 = leaderboardBox.childNodeWithName("scoreFour") as! SKLabelNode
        score5 = leaderboardBox.childNodeWithName("scoreFive") as! SKLabelNode
        
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
        
        // setting the leader board to the default values
        clearLeaderboard()
    }
    
    func getLeaders() {
        // connect to the BaaS and get the top rankings for the chosen level
        App42API.initializeWithAPIKey(apiKey, andSecretKey: secretKey)
        let scoreBoardService = App42API.buildScoreBoardService() as? ScoreBoardService
        if self.globalSelection == true {
            scoreBoardService?.getTopRankings(gameName, completionBlock: { (success, response, exception) -> Void in
                if(success)
                {
                    // set the game and score list
                    let game = response as! Game
                    let scoreList = game.scoreList
                    var starRating:Int!
                    
                    // loop through the scores from the BaaS
                    for score in scoreList
                    {
                        // pull in the score and set it to a double
                        let scoreValue = score.value as Double
                        
                        if scoreValue >= 75 {
                            starRating = 3
                        } else if scoreValue <= 74 && scoreValue >= 50 {
                            starRating = 2
                        } else if scoreValue <= 49 && scoreValue >= 30 {
                            starRating = 1
                        } else if scoreValue <= 29 {
                            starRating = 0
                        }
                        
                        // populate a score object and append it to the score array
                        let currentScore:Score = Score(_name: score.userName, _score: scoreValue, _stars: starRating)
                        self.leaderboardScores.append(currentScore)
                    }
                    
                    self.filteredScores = self.leaderboardScores
                    
                    self.filterLeaderboard(5)
                }
                else
                {
                    // print any issues to the console
                    print(exception.reason!)
                    print(exception.appErrorCode)
                    print(exception.httpErrorCode)
                    print(exception.userInfo!)
                }
            })
        } else if self.globalSelection == false {
            scoreBoardService?.getScoresByUser(gameName, gameUserName:"Sam", completionBlock: { (success, response, exception) -> Void in
                
                if(success)
                {
                    // set the game and score list
                    let game = response as! Game
                    let scoreList = game.scoreList
                    var starRating:Int!
                    
                    // loop through the scores from the BaaS
                    for score in scoreList
                    {
                        // pull in the score and set it to a double
                        let scoreValue = score.value as Double
                        
                        if scoreValue >= 75 {
                            starRating = 3
                        } else if scoreValue <= 74 && scoreValue >= 50 {
                            starRating = 2
                        } else if scoreValue <= 49 && scoreValue >= 30 {
                            starRating = 1
                        } else if scoreValue <= 29 {
                            starRating = 0
                        }
                        
                        // populate a score object and append it to the score array
                        let currentScore:Score = Score(_name: score.userName, _score: scoreValue, _stars: starRating)
                        self.leaderboardScores.append(currentScore)
                    }
                    
                    self.leaderboardScores.sortInPlace({ $0.userScore > $1.userScore})
                    
                    self.filteredScores = self.leaderboardScores
                    
                    self.topScore = Score(_name: self.leaderboardScores[0].userName,
                        _score: self.leaderboardScores[0].userScore,
                        _stars: self.leaderboardScores[0].starRating)
                    
                    self.filterLeaderboard(5)
                }
                else
                {
                    // print any issues to the console
                    print(exception.reason!)
                    print(exception.appErrorCode)
                    print(exception.httpErrorCode)
                    print(exception.userInfo!)
                }
            })
        }

    }
    
    func clearLeaderboard() {
        // setting the user name to the default text
        name1.text = "No Score"
        name2.text = "No Score"
        name3.text = "No Score"
        name4.text = "No Score"
        name5.text = "No Score"
        
        // setting the score to the default text
        score1.text = "No Score"
        score2.text = "No Score"
        score3.text = "No Score"
        score4.text = "No Score"
        score5.text = "No Score"
        
        // hiding all of the stars
        scoreOneStarOne.alpha = 0
        scoreOneStarTwo.alpha = 0
        scoreOneStarThree.alpha = 0
        scoreTwoStarOne.alpha = 0
        scoreTwoStarTwo.alpha = 0
        scoreTwoStarThree.alpha = 0
        scoreThreeStarOne.alpha = 0
        scoreThreeStarTwo.alpha = 0
        scoreThreeStarThree.alpha = 0
        scoreFourStarOne.alpha = 0
        scoreFourStarTwo.alpha = 0
        scoreFourStarThree.alpha = 0
        scoreFiveStarOne.alpha = 0
        scoreFiveStarTwo.alpha = 0
        scoreFiveStarThree.alpha = 0
    }
    
    func filterLeaderboard(filter:Int) {
        clearLeaderboard()
        
        if filter >= 0 && filter < 4 {
            self.filteredScores = []
            
            for score in self.leaderboardScores {
                if score.starRating == filter {
                    self.filteredScores.append(score)
                }
            }
        } else {
            self.filteredScores = self.leaderboardScores
        }
        
        populateLeaderboard()
    }
    
    func populateLeaderboard() {
        // set an integer for a row counter for leaderboard population
        var i:Int = 1
        
        for leaders in self.filteredScores {
            if i == 1 {
                // set the user and score to the leaderboard display
                self.name1.text = leaders.userName
                self.score1.text = String(leaders.userScore)
                
                if leaders.starRating == 3 {
                    self.scoreOneStarOne.alpha = 1
                    self.scoreOneStarTwo.alpha = 1
                    self.scoreOneStarThree.alpha = 1
                    
                } else if leaders.starRating == 2 {
                    self.scoreOneStarOne.alpha = 1
                    self.scoreOneStarTwo.alpha = 1
                    self.scoreOneStarThree.alpha = 0
                } else if leaders.starRating == 1 {
                    self.scoreOneStarOne.alpha = 1
                    self.scoreOneStarTwo.alpha = 0
                    self.scoreOneStarThree.alpha = 0
                } else if leaders.starRating == 0 {
                    self.scoreOneStarOne.alpha = 0
                    self.scoreOneStarTwo.alpha = 0
                    self.scoreOneStarThree.alpha = 0
                }
                
            } else if i == 2 {
                // set the user and score to the leaderboard display
                self.name2.text = leaders.userName
                self.score2.text = String(leaders.userScore)
                if leaders.userScore >= 75 {
                    self.scoreTwoStarOne.alpha = 1
                    self.scoreTwoStarTwo.alpha = 1
                    self.scoreTwoStarThree.alpha = 1
                    
                } else if leaders.userScore <= 74 && leaders.userScore >= 50 {
                    self.scoreTwoStarOne.alpha = 1
                    self.scoreTwoStarTwo.alpha = 1
                    self.scoreTwoStarThree.alpha = 0
                } else if leaders.userScore <= 49 && leaders.userScore >= 30 {
                    self.scoreTwoStarOne.alpha = 1
                    self.scoreTwoStarTwo.alpha = 0
                    self.scoreTwoStarThree.alpha = 0
                } else if leaders.userScore <= 29 {
                    self.scoreTwoStarOne.alpha = 0
                    self.scoreTwoStarTwo.alpha = 0
                    self.scoreTwoStarThree.alpha = 0
                }
                
            } else if i == 3 {
                self.name3.text = leaders.userName
                self.score3.text = String(leaders.userScore)
                
                if leaders.userScore >= 75 {
                    self.scoreThreeStarOne.alpha = 1
                    self.scoreThreeStarTwo.alpha = 1
                    self.scoreThreeStarThree.alpha = 1
                    
                } else if leaders.userScore <= 74 && leaders.userScore >= 50 {
                    self.scoreThreeStarOne.alpha = 1
                    self.scoreThreeStarTwo.alpha = 1
                    self.scoreThreeStarThree.alpha = 0
                } else if leaders.userScore <= 49 && leaders.userScore >= 30 {
                    self.scoreThreeStarOne.alpha = 1
                    self.scoreThreeStarTwo.alpha = 0
                    self.scoreThreeStarThree.alpha = 0
                } else if leaders.userScore <= 29 {
                    self.scoreThreeStarOne.alpha = 0
                    self.scoreThreeStarTwo.alpha = 0
                    self.scoreThreeStarThree.alpha = 0
                }
                
            } else if i == 4 {
                self.name4.text = leaders.userName
                self.score4.text = String(leaders.userScore)
                
                if leaders.userScore >= 75 {
                    self.scoreFourStarOne.alpha = 1
                    self.scoreFourStarTwo.alpha = 1
                    self.scoreFourStarThree.alpha = 1
                    
                } else if leaders.userScore <= 74 && leaders.userScore >= 50 {
                    self.scoreFourStarOne.alpha = 1
                    self.scoreFourStarTwo.alpha = 1
                    self.scoreFourStarThree.alpha = 0
                } else if leaders.userScore <= 49 && leaders.userScore >= 30 {
                    self.scoreFourStarOne.alpha = 1
                    self.scoreFourStarTwo.alpha = 0
                    self.scoreFourStarThree.alpha = 0
                } else if leaders.userScore <= 29 {
                    self.scoreFourStarOne.alpha = 0
                    self.scoreFourStarTwo.alpha = 0
                    self.scoreFourStarThree.alpha = 0
                }
                
            } else if i == 5 {
                self.name5.text = leaders.userName
                self.score5.text = String(leaders.userScore)
                
                if leaders.userScore >= 75 {
                    self.scoreFiveStarOne.alpha = 1
                    self.scoreFiveStarTwo.alpha = 1
                    self.scoreFiveStarThree.alpha = 1
                    
                } else if leaders.userScore <= 74 && leaders.userScore >= 50 {
                    self.scoreFiveStarOne.alpha = 1
                    self.scoreFiveStarTwo.alpha = 1
                    self.scoreFiveStarThree.alpha = 0
                } else if leaders.userScore <= 49 && leaders.userScore >= 30 {
                    self.scoreFiveStarOne.alpha = 1
                    self.scoreFiveStarTwo.alpha = 0
                    self.scoreFiveStarThree.alpha = 0
                } else if leaders.userScore <= 29 {
                    self.scoreFiveStarOne.alpha = 0
                    self.scoreFiveStarTwo.alpha = 0
                    self.scoreFiveStarThree.alpha = 0
                }
                
            } else if i > 5 {
                break;
            }
            
            // increase the row counter
            i += 1
        }
        
        if globalSelection == false {
            let usersTopScore:String = String(self.topScore.userScore)
            let topStarRating:String = String(self.topScore.starRating)
            let content: FBSDKShareLinkContent = FBSDKShareLinkContent()
            content.contentURL = NSURL(string: "https://www.finalhope.com")!
            content.contentTitle = self.topScore.userName + " is sharing his top score!"
            content.contentDescription = self.topScore.userName + " has scored " + usersTopScore + " points earning " + topStarRating + " stars in Final Hope!"
            shareButton.shareContent = content
            shareButton.center = CGPoint(x: 575, y: 215)
            self.view!.addSubview(shareButton)
        }
        
        // show the leaderboard
        self.leaderboardBox.alpha = 1
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
                
                self.shareButton.removeFromSuperview()
                self.view?.presentScene(mainMenu, transition: transitionToScene)
            } else if spriteName == "levelOneLeaderboardButton" {
                // show level one leaderboard
                
                // clear the leaderboard
                clearLeaderboard()
                
                // setting which leaderboard to pull from the BaaS
                self.gameName = "LevelOne"
                self.globalSelection = true
                
                levelOneLeaderboardButton.fontColor = selectedColor
                globalScoreSelection.alpha = 1
                globalScoreSelection.fontColor = selectedColor
                localScoreSelection.alpha = 1
                
                filterTitle.alpha = 1
                allStarFilter.alpha = 1
                allStarFilter.fontColor = selectedColor
                threeStarFilter.alpha = 1
                twoStarFilter.alpha = 1
                oneStarFilter.alpha = 1
                zeroStarFilter.alpha = 1
                
                // hiding the leaderboard and clearing the array
                self.leaderboardBox.alpha = 0
                self.leaderboardScores = []
                
                // pulling all of the relevent scores
                getLeaders()
            } else if spriteName == "levelTwoLeaderboardButton" {
                // show level two leaderboard
            } else if spriteName == "levelThreeLeaderboardButton" {
                // show level three leaderboard
            } else if spriteName == "globalScoreSelection" {
                // display filters and show 'all' leaderboard
                
                self.globalSelection = true
                self.leaderboardScores = []
                self.globalScoreSelection.fontColor = selectedColor
                self.localScoreSelection.fontColor = unselectedColor
                self.shareButton.alpha = 0
                self.shareTopScoreTitle.alpha = 0
                
                clearLeaderboard()
                
                getLeaders()
            } else if spriteName == "localScoreSelection" {
                // display filters and show 'all' leaderboard
                
                self.globalSelection = false
                self.leaderboardScores = []
                self.globalScoreSelection.fontColor = unselectedColor
                self.localScoreSelection.fontColor = selectedColor
                self.shareButton.alpha = 1
                self.shareTopScoreTitle.alpha = 1
                
                clearLeaderboard()
                
                getLeaders()
            } else if spriteName == "allStarFilter" {
                // display top 5 across all star levels
                self.filteredScores = self.leaderboardScores
                
                self.allStarFilter.fontColor = selectedColor
                self.threeStarFilter.fontColor = unselectedColor
                self.twoStarFilter.fontColor = unselectedColor
                self.oneStarFilter.fontColor = unselectedColor
                self.zeroStarFilter.fontColor = unselectedColor
                
                clearLeaderboard()
                filterLeaderboard(5)
                
            } else if spriteName == "threeStarFilter" {
                // display only 3 star ratings
                
                self.allStarFilter.fontColor = unselectedColor
                self.threeStarFilter.fontColor = selectedColor
                self.twoStarFilter.fontColor = unselectedColor
                self.oneStarFilter.fontColor = unselectedColor
                self.zeroStarFilter.fontColor = unselectedColor
                
                clearLeaderboard()
                filterLeaderboard(3)
            } else if spriteName == "twoStarFilter" {
                // display only 2 star ratings
                
                self.allStarFilter.fontColor = unselectedColor
                self.threeStarFilter.fontColor = unselectedColor
                self.twoStarFilter.fontColor = selectedColor
                self.oneStarFilter.fontColor = unselectedColor
                self.zeroStarFilter.fontColor = unselectedColor
                
                clearLeaderboard()
                filterLeaderboard(2)
            } else if spriteName == "oneStarFilter" {
                // display only 1 star ratings
                
                self.allStarFilter.fontColor = unselectedColor
                self.threeStarFilter.fontColor = unselectedColor
                self.twoStarFilter.fontColor = unselectedColor
                self.oneStarFilter.fontColor = selectedColor
                self.zeroStarFilter.fontColor = unselectedColor
                
                clearLeaderboard()
                filterLeaderboard(1)
            } else if spriteName == "zeroStarFilter" {
                // display only 0 star ratings
                
                self.allStarFilter.fontColor = unselectedColor
                self.threeStarFilter.fontColor = unselectedColor
                self.twoStarFilter.fontColor = unselectedColor
                self.oneStarFilter.fontColor = unselectedColor
                self.zeroStarFilter.fontColor = selectedColor
                
                clearLeaderboard()
                filterLeaderboard(0)
            }
        }
    }
}
