// Samuel Hubbard
// MGD - 1604
// Final Hope
// Current Version: Beta

import SpriteKit

class InstructionsScene: SKScene {
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let mainMenu = MainMenuScene(fileNamed: "MainMenuScene")!
        
        mainMenu.scaleMode = .Fill
        let transitionToScene:SKTransition = SKTransition.crossFadeWithDuration(1.0)
        
        self.view?.presentScene(mainMenu, transition: transitionToScene)
    }
}
