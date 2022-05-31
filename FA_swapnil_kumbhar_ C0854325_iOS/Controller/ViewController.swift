//
//  ViewController.swift
//  FA_swapnil_kumbhar_ C0854325_iOS
//
//  Created by Swapnil Kumbhar on 2022-05-27.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var playerTwoName: UITextView!
    @IBOutlet weak var playerOneName: UITextView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var manageContext: NSManagedObjectContext!
    var oldBoard: Board?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageContext = appDelegate.persistentContainer.viewContext;
        loadCoreData(type: "data_check");
    }
    
    func showSimpleAlert() {
            let alert = UIAlertController(title: "Data found?", message: "Do you want to load previous game?",
                                          preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.loadCoreData(type: "data_load")
        }));
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in
            
        }));
        self.present(alert, animated: true, completion: nil)
    }
    func loadCoreData(type: String) {

        let fetchRequest = NSFetchRequest<BoardData>(entityName: "BoardData");

        do {
            let results = try manageContext.fetch(fetchRequest)
            if let board = results.first {
                switch type {
                case "data_check":
                    showSimpleAlert();
                default:
                    let p1 = Player(name: board.player_one_name!, sign: .CRICLE)
                    let p2 = Player(name: board.player_two_name!, sign: .CROSS)
                    playerOneName.text = p1.name;
                    playerTwoName.text = p2.name;
                    oldBoard = Board(player1: p1, player2: p2)
                    setSlot(b: oldBoard!, sign: board.slot00, x: 0, y: 0)
                    setSlot(b: oldBoard!, sign: board.slot01, x: 0, y: 1)
                    setSlot(b: oldBoard!, sign: board.slot02, x: 0, y: 2)
                    setSlot(b: oldBoard!, sign: board.slot10, x: 1, y: 0)
                    setSlot(b: oldBoard!, sign: board.slot11, x: 1, y: 1)
                    setSlot(b: oldBoard!, sign: board.slot12, x: 1, y: 2)
                    setSlot(b: oldBoard!, sign: board.slot20, x: 2, y: 0)
                    setSlot(b: oldBoard!, sign: board.slot21, x: 2, y: 1)
                    setSlot(b: oldBoard!, sign: board.slot22, x: 2, y: 2)
                    oldBoard!.playerOneScore = Int(board.player_one_score!) ?? 0
                    oldBoard!.playerTwoScore = Int(board.player_two_score!) ?? 0
                    oldBoard!.counter = Int(board.counter)
                    if (board.current_player_sign == "cross") {
                        oldBoard!.currentPlayer = oldBoard!.player2
                    } else {
                        oldBoard!.currentPlayer = oldBoard!.player1
                    }
                    performSegue(withIdentifier: "game_screen_segue", sender: self)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func setSlot(b: Board, sign: String?, x: Int, y: Int) {
        if (sign != nil) {
            switch sign {
                case "cross" : b.slots[x][y] = .CROSS
                case "circle": b.slots[x][y] = .CRICLE
                default: b.slots[x][y] = .NONE
            }
        } else {
            b.slots[x][y] = .NONE
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is GameScreenController {
            if let vc = segue.destination as? GameScreenController {
                vc.playerOneNameLabel = playerOneName.text;
                vc.playerTwoNameLabel = playerTwoName.text;
                vc.oldBoard = oldBoard;
            }
        }
    }

}

