// Samuel Hubbard
// MGD - 1604 & IAD - 1605
// Final Hope
// Current Version: Gold

import SpriteKit


class AchievementsCollection {
    var achievementName:String!
    var achievementDescription:String!
    var achievementDate:NSDate!
    
    init(_achievement:String, _description:String, _date:NSDate) {
        achievementName = _achievement
        achievementDescription = _description
        achievementDate = _date
    }
}