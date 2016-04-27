// Samuel Hubbard
// MGD - 1604
// Final Hope
// Current Version: Gold

import UIKit
import SpriteKit
import AVFoundation

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = MainMenuScene(fileNamed:"MainMenuScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .Fill
            
            // preloading the texture atlas
            var atlasArray = [SKTextureAtlas]()
            atlasArray.append(SKTextureAtlas(named: "Explosion"))
            SKTextureAtlas.preloadTextureAtlases(atlasArray) {}
            
            // Preloading all sound files
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

            
            // show the scene
            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
