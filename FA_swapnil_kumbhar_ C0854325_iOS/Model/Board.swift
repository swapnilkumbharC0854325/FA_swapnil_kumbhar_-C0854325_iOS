//
//  Board.swift
//  FA_swapnil_kumbhar_ C0854325_iOS
//
//  Created by Swapnil Kumbhar on 2022-05-27.
//

import Foundation

class Board {
    var slots: [[PLAYER_SIGN]] = Array(repeating: Array(repeating: PLAYER_SIGN.NONE, count: 3), count: 3);
    let player1: Player;
    let player2: Player;
    var winner: Player?;
    var currentPlayer: Player;
    
    init(player1: Player, player2: Player) {
        self.player1 = player1;
        self.player2 = player2;
        self.currentPlayer = player1;
    }
    
    func play(positionX: Int, positionY: Int) -> Bool {
        if (winner == nil) {
            if (positionX > 2 || positionY > 2 || positionX < 0 || positionY < 0) {
                return false;
            }
            if self.slots[positionX][positionY] != PLAYER_SIGN.NONE {
                return false;
            }
            self.slots[positionX][positionY] = currentPlayer.sign;
            return true;
        }
        return false
    }
    
    func checkResult() {
        // vertical check
        for i in 0...2{
            if (isEqual(a: slots[i][0], b: slots[i][1], c: slots[i][2])) {
                winner = currentPlayer;
                return;
            }
        }
        
        // horizontal check
        for i in 0...2{
            if (isEqual(a: slots[0][i], b: slots[1][i], c: slots[2][i])) {
                winner = currentPlayer;
                return;
            }
        }
        
        // diagonal check
        if (isEqual(a: slots[0][0], b: slots[1][1], c: slots[2][2])) {
            winner = currentPlayer;
            return;
        }
        
        // reverse diagonal
        if (isEqual(a: slots[0][2], b: slots[1][1], c: slots[2][0])) {
            winner = currentPlayer;
            return;
        }
        
    }
    
    private func isEqual(a: PLAYER_SIGN, b: PLAYER_SIGN, c: PLAYER_SIGN) -> Bool {
        if (a == PLAYER_SIGN.NONE) {
            return false
        }
        return a == b && b == c && a == c;
    }
    
    
    func switchPlayer() {
        if currentPlayer.sign == player1.sign {
            currentPlayer = player2
        } else {
            currentPlayer = player1
        }
    }
}
