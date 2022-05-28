//
//  Board.swift
//  FA_swapnil_kumbhar_ C0854325_iOS
//
//  Created by Swapnil Kumbhar on 2022-05-27.
//

import Foundation

class Board {
    var availablePlaces: [[PLAYER_SIGN]] = Array(repeating: Array(repeating: PLAYER_SIGN.NONE, count: 3), count: 3);
    let player1: Player;
    let player2: Player;
    
    init(player1: Player, player2: Player) {
        self.player1 = player1;
        self.player2 = player2;
    }
    
    func play(player: Player, positionX: Int, positionY: Int) {
        if (positionX > 2 || positionY > 2 || positionX < 0 || positionY < 0) {
            return;
        }
        if self.availablePlaces[positionX][positionY] != PLAYER_SIGN.NONE {
            return;
        }
        self.availablePlaces[positionX][positionY] = player.sign;
    }
}
