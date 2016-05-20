// Samuel Hubbard
// MGD - 1604 & IAD - 1605
// Final Hope
// Current Version: Gold

import SpriteKit


class Score {
    var userName:String!
    var userScore:Double!
    var starRating:Int!
    
    init(_name:String, _score:Double, _stars:Int) {
        userName = _name
        userScore = _score
        starRating = _stars
    }
}