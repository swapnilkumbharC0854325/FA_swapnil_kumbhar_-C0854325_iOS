//
//  GameScreenController.swift
//  FA_swapnil_kumbhar_ C0854325_iOS
//
//  Created by Swapnil Kumbhar on 2022-05-27.
//

import UIKit

class GameScreenController: UIViewController {

    @IBOutlet weak var place1: UIImageView!
    @IBOutlet weak var place2: UIImageView!
    @IBOutlet weak var place3: UIImageView!
    @IBOutlet weak var place4: UIImageView!
    @IBOutlet weak var place5: UIImageView!
    @IBOutlet weak var place6: UIImageView!
    @IBOutlet weak var place7: UIImageView!
    @IBOutlet weak var place8: UIImageView!
    @IBOutlet weak var place9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        place1.addGestureRecognizer(setTapGestureRecognizer());
        place2.addGestureRecognizer(setTapGestureRecognizer());
        place3.addGestureRecognizer(setTapGestureRecognizer());
        place4.addGestureRecognizer(setTapGestureRecognizer());
        place5.addGestureRecognizer(setTapGestureRecognizer());
        place6.addGestureRecognizer(setTapGestureRecognizer());
        place7.addGestureRecognizer(setTapGestureRecognizer());
        place8.addGestureRecognizer(setTapGestureRecognizer());
        place9.addGestureRecognizer(setTapGestureRecognizer());
                                                    
    }
    
    func setTapGestureRecognizer() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(placeClickListner))
    }
    
    @objc func placeClickListner(tapRecongnizer: UITapGestureRecognizer) {
        print(tapRecongnizer.view?.tag);
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
