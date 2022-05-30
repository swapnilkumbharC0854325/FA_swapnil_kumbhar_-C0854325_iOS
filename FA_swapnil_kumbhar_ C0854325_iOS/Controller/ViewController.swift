//
//  ViewController.swift
//  FA_swapnil_kumbhar_ C0854325_iOS
//
//  Created by Swapnil Kumbhar on 2022-05-27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerTwoName: UITextView!
    @IBOutlet weak var playerOneName: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is GameScreenController {
            if let vc = segue.destination as? GameScreenController {
                vc.playerOneNameLabel = playerOneName.text;
                vc.playerTwoNameLabel = playerTwoName.text;
            }
        }
    }

}

