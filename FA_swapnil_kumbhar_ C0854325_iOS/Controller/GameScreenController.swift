//
//  GameScreenController.swift
//  FA_swapnil_kumbhar_ C0854325_iOS
//
//  Created by Swapnil Kumbhar on 2022-05-27.
//

import UIKit

class GameScreenController: UIViewController {
    
    var board = Board(player1: Player(name: "Player 1", sign: PLAYER_SIGN.CRICLE), player2: Player(name: "Player 2", sign: PLAYER_SIGN.CROSS))
    
    
    @IBOutlet weak var place1: SignView!
    @IBOutlet weak var place2: SignView!
    @IBOutlet weak var place3: SignView!
    @IBOutlet weak var place4: SignView!
    @IBOutlet weak var place5: SignView!
    @IBOutlet weak var place6: SignView!
    @IBOutlet weak var place7: SignView!
    @IBOutlet weak var place8: SignView!
    @IBOutlet weak var place9: SignView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initilizeSignView(signView: place1, positionX: 0, positionY: 0)
        initilizeSignView(signView: place2, positionX: 1, positionY: 0)
        initilizeSignView(signView: place3, positionX: 2, positionY: 0)
        
        initilizeSignView(signView: place4, positionX: 0, positionY: 1)
        initilizeSignView(signView: place5, positionX: 1, positionY: 1)
        initilizeSignView(signView: place6, positionX: 2, positionY: 1)
        
        initilizeSignView(signView: place7, positionX: 0, positionY: 2)
        initilizeSignView(signView: place8, positionX: 1, positionY: 2)
        initilizeSignView(signView: place9, positionX: 2, positionY: 2)
    }
    
    func initilizeSignView(signView: SignView, positionX: Int, positionY: Int) {
        
        let tabGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(placeClickListner));
        signView.addGestureRecognizer(tabGestureRecognizer)
        signView.positionX = positionX;
        signView.positionY = positionY;
        
    }
    
    @objc func placeClickListner(tapRecongnizer: UITapGestureRecognizer) {
        if let view = tapRecongnizer.view as? SignView {
            if board.play(positionX: view.positionX, positionY: view.positionY) {
                view.player_sign = board.currentPlayer.sign;
                board.checkResult()
                board.switchPlayer()
                if let w = board.winner {
                    print(w);
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
    }
    */
    
    
}
