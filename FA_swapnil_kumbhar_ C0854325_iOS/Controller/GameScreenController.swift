//
//  GameScreenController.swift
//  FA_swapnil_kumbhar_ C0854325_iOS
//
//  Created by Swapnil Kumbhar on 2022-05-27.
//

import UIKit
import CoreData

class GameScreenController: UIViewController {
    
    var board: Board?;
    var oldBoard: Board?;
    
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
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var manageContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        if (oldBoard == nil) {
            board = Board(player1: Player(name: playerOneNameLabel, sign: PLAYER_SIGN.CRICLE), player2: Player(name: playerTwoNameLabel, sign: PLAYER_SIGN.CROSS));
        } else {
            board = oldBoard;
        }
        
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
        
        manageContext = appDelegate.persistentContainer.viewContext;
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveCoreData), name: UIApplication.willResignActiveNotification, object: nil)
        
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            board!.undo(view: lastMoveXSignView);
        }
    }
    
    @objc func swipeGestureAction(swipeGesture: UISwipeGestureRecognizer) {
        if swipeGesture.state == .ended {
            if board!.state != GAME_STATE.PLAYING {
                board!.reset()
                initializeGame();
            }
        }
    }
    
    func initializeGame() {
        place1.player_sign = board!.slots[0][0];
        place2.player_sign = board!.slots[1][0];
        place3.player_sign = board!.slots[2][0];
        
        place4.player_sign = board!.slots[0][1];
        place5.player_sign = board!.slots[1][1];
        place6.player_sign = board!.slots[2][1];
        
        place7.player_sign = board!.slots[0][2];
        place8.player_sign = board!.slots[1][2];
        place9.player_sign = board!.slots[2][2];
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
                saveCoreData()
                return
            }
        }
    }
    
    @objc func saveCoreData() {
        clearCodeData()
        let boardDataEntity = NSEntityDescription.insertNewObject(forEntityName: "BoardData", into: manageContext);
        boardDataEntity.setValue(playerOneNameLabel, forKey: "player_one_name")
        boardDataEntity.setValue(playerTwoNameLabel, forKey: "player_two_name")
        for x in 0...2 {
            for y in 0...2 {
                setSlotData(x: x, y: y, boardDataEntity: boardDataEntity)
            }
        }
        boardDataEntity.setValue(String(board!.playerOneScore), forKey: "player_one_score")
        boardDataEntity.setValue(String(board!.playerTwoScore), forKey: "player_two_score")
        boardDataEntity.setValue(board!.counter, forKey: "counter")
        let sign = self.board?.currentPlayer.sign;
        switch sign {
        case .CRICLE:
            boardDataEntity.setValue("circle", forKey: "current_player_sign")
        case .CROSS:
            boardDataEntity.setValue("cross", forKey: "current_player_sign")
        default:
            boardDataEntity.setValue("none", forKey: "current_player_sign")
        }
        appDelegate.saveContext()
    }
    
    func setSlotData(x: Int, y: Int, boardDataEntity: NSManagedObject) {
        let sign = self.board?.slots[x][y];
        switch sign {
        case .CRICLE:
            boardDataEntity.setValue("circle", forKey: "slot" + String(x) + String(y))
        case .CROSS:
            boardDataEntity.setValue("cross", forKey: "slot" + String(x) + String(y))
        default:
            boardDataEntity.setValue("none", forKey: "slot" + String(x) + String(y))
        }
    }
    
    
    func clearCodeData() {
        let fetchRequest = NSFetchRequest<BoardData>(entityName: "BoardData");
        do {
            let results = try manageContext.fetch(fetchRequest)
            for result in results {
                manageContext.delete(result)
            }
        } catch {
            print("Error deleting records \(error)")
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
