//
//  Player.swift
//  FA_swapnil_kumbhar_ C0854325_iOS
//
//  Created by Swapnil Kumbhar on 2022-05-27.
//

import Foundation

enum PLAYER_SIGN {
    case NONE
    case CROSS
    case CRICLE
}

class Player: NSObject {
    var name: String;
    var sign: PLAYER_SIGN;
    
    init(name: String, sign: PLAYER_SIGN) {
        self.name = name;
        self.sign = sign;
    }
    
    override var description: String { return "Player Name: \(name)" }
}
