//
//  GameScreenController.swift
//  FA_swapnil_kumbhar_ C0854325_iOS
//
//  Created by Swapnil Kumbhar on 2022-05-27.
//

import UIKit

class GameScreenController: UIViewController {
    
    var board: Board?;
    
    @IBOutlet weak var playerOneName: UITextView!
    @IBOutlet weak var playerTwoName: UITextView!
    var playerOneNameLabel = "";
    var playerTwoNameLabel = "";
    @IBOutlet weak var place1: SignView!
    @IBOutlet weak var place2: SignView!
    @IBOutlet weak var place3: SignView!
    @IBOutlet weak var place4: SignView!
    @IBOutlet weak var place5: SignView!
    @IBOutlet weak var place6: SignView!
    @IBOutlet weak var place7: SignView!
    @IBOutlet weak var place8: SignView!
    @IBOutlet weak var place9: SignView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var winnerName: UILabel!
    var lastMoveXSignView: SignView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        board = Board(player1: Player(name: playerOneNameLabel, sign: PLAYER_SIGN.CRICLE), player2: Player(name: playerTwoNameLabel, sign: PLAYER_SIGN.CROSS));
        playerTwoName.text = playerTwoNameLabel;
        playerOneName.text = playerOneNameLabel;
        
        initilizeSignView(signView: place1, positionX: 0, positionY: 0)
        initilizeSignView(signView: place2, positionX: 1, positionY: 0)
        initilizeSignView(signView: place3, positionX: 2, positionY: 0)
        
        initilizeSignView(signView: place4, positionX: 0, positionY: 1)
        initilizeSignView(signView: place5, positionX: 1, positionY: 1)
        initilizeSignView(signView: place6, positionX: 2, positionY: 1)
         
        initilizeSignView(signView: place7, positionX: 0, positionY: 2)
        initilizeSignView(signView: place8, positionX: 1, positionY: 2)
        initilizeSignView(signView: place9, positionX: 2, positionY: 2)
         
        initializeGame();
        scoreLabel.text = String(board!.playerOneScore) + "-" + String(board!.playerTwoScore);
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureAction))
        self.view.addGestureRecognizer(swipeGesture);
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            board!.undo(view: lastMoveXSignView);
        }
    }
    
    @objc func swipeGestureAction(swipeGesture: UISwipeGestureRecognizer) {
        if swipeGesture.state == .ended {
            if board!.state != GAME_STATE.PLAYING {
                initializeGame();
            }
        }
    }
    
    func initializeGame() {
        place1.player_sign = PLAYER_SIGN.NONE;
        place2.player_sign = PLAYER_SIGN.NONE;
        place3.player_sign = PLAYER_SIGN.NONE;
        place4.player_sign = PLAYER_SIGN.NONE;
        place5.player_sign = PLAYER_SIGN.NONE;
        place6.player_sign = PLAYER_SIGN.NONE;
        place7.player_sign = PLAYER_SIGN.NONE;
        place8.player_sign = PLAYER_SIGN.NONE;
        place9.player_sign = PLAYER_SIGN.NONE;
        board!.reset()
        winnerName.text = "";
    }
    
    func initilizeSignView(signView: SignView, positionX: Int, positionY: Int) {
        
        let tabGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(placeClickListner));
        signView.addGestureRecognizer(tabGestureRecognizer)
        signView.positionX = positionX;
        signView.positionY = positionY;
    }
    
    @objc func placeClickListner(tapRecongnizer: UITapGestureRecognizer) {
        if let view = tapRecongnizer.view as? SignView {
            if board!.play(positionX: view.positionX, positionY: view.positionY) {
                lastMoveXSignView = view
                view.player_sign = board!.currentPlayer.sign;
                board!.checkResult()
                board!.switchPlayer()
                if board!.winner != nil {
                    scoreLabel.text = String(board!.playerOneScore) + "-" + String(board!.playerTwoScore);
                    winnerName.text = board!.winner!.name + " won";
                }
                if board!.state == .TIE {
                    winnerName.text = "Draw";
                }
                return
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is GameScreenController {
            let vc = segue.destination as? GameScreenController
            print("Hello 2")
        }
    }
     
      */
    
}
