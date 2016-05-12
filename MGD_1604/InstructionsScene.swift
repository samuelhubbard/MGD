// Samuel Hubbard
// MGD - 1604 & IAD - 1605
// Final Hope
// Current Version: Gold

import SpriteKit

class InstructionsScene: SKScene {
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // upon touch, load back into the main menu
        let mainMenu = MainMenuScene(fileNamed: "MainMenuScene")!
        
        mainMenu.scaleMode = .Fill
        let transitionToScene:SKTransition = SKTransition.crossFadeWithDuration(1.0)
        
        self.view?.presentScene(mainMenu, transition: transitionToScene)
    }
}
