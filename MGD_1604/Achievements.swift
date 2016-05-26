// Samuel Hubbard
// MGD - 1604 & IAD - 1605
// Final Hope
// Current Version: Gold

import SpriteKit


class Achievements {
    var userName:String!
    var achievementName:String!
    var achievementDescription:String!
    var gameName:String!
    
    init(_user:String, _achievement:String, _description:String, _game:String) {
        userName = _user
        achievementName = _achievement
        achievementDescription = _description
        gameName = _game
    }
}