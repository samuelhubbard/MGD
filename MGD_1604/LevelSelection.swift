//
//  LevelSelection.swift
//  Final Hope
//
//  Created by Samuel Hubbard on 5/21/16.
//  Copyright © 2016 Samuel Hubbard. All rights reserved.
//

import SpriteKit

class LevelSelection: SKScene {
    
    var levelOneStart:SKLabelNode = SKLabelNode()
    var levelTwoStart:SKLabelNode = SKLabelNode()
    var levelThreeStart:SKLabelNode = SKLabelNode()

    override func didMoveToView(view: SKView) {
        levelOneStart = self.childNodeWithName("levelOneStart") as! SKLabelNode
        levelTwoStart = self.childNodeWithName("levelTwoStart") as! SKLabelNode
        levelThreeStart = self.childNodeWithName("levelThreeStart") as! SKLabelNode
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
            
            if spriteName == "levelOneStart" {
                // set the scene that will be transitioned into
                let gameMode:GameScene = GameScene(fileNamed: "GameScene")!
                
                // add the required definitions (scaleMode and the transition animation)
                gameMode.scaleMode = .Fill
                let transitionToScene:SKTransition = SKTransition.crossFadeWithDuration(2.0)
                
                // perform the transition
                self.view?.presentScene(gameMode, transition: transitionToScene)
            } else if spriteName == "levelTwoStart" {
                // set the scene that will be transitioned into
                let gameMode:GameScene2 = GameScene2(fileNamed: "GameScene2")!
                
                // add the required definitions (scaleMode and the transition animation)
                gameMode.scaleMode = .Fill
                let transitionToScene:SKTransition = SKTransition.crossFadeWithDuration(2.0)
                
                // perform the transition
                self.view?.presentScene(gameMode, transition: transitionToScene)
            } else if spriteName == "levelThreeStart" {
                // set the scene that will be transitioned into
                let gameMode:GameScene = GameScene(fileNamed: "GameScene")!
                
                // add the required definitions (scaleMode and the transition animation)
                gameMode.scaleMode = .Fill
                let transitionToScene:SKTransition = SKTransition.crossFadeWithDuration(2.0)
                
                // perform the transition
                self.view?.presentScene(gameMode, transition: transitionToScene)
            } else if spriteName == "backToMainMenuButton" {
                // set the scene that will be transitioned into
                let mainMenu:MainMenuScene = MainMenuScene(fileNamed: "MainMenuScene")!
                
                // add the required definitions (scaleMode and the transition animation)
                mainMenu.scaleMode = .Fill
                let transitionToScene:SKTransition = SKTransition.crossFadeWithDuration(2.0)
                
                // perform the transition
                self.view?.presentScene(mainMenu, transition: transitionToScene)
            }
        }
    }
}
