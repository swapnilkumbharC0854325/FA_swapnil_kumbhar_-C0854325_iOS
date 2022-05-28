//
//  SignView.swift
//  FA_swapnil_kumbhar_ C0854325_iOS
//
//  Created by Swapnil Kumbhar on 2022-05-28.
//

import UIKit

@IBDesignable
class SignView: UIView {
    
    public var player_sign: PLAYER_SIGN = PLAYER_SIGN.NONE { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        switch player_sign {
        case .NONE:
            if let faceCardImage = UIImage(named: "card_bg", in: Bundle(for: self.classForCoder), compatibleWith: traitCollection) {
                faceCardImage.draw(in: bounds.zoom(by: 1))
                let tabGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(placeClickListner));
                self.addGestureRecognizer(tabGestureRecognizer)
            }
        case .CROSS:
            if let faceCardImage = UIImage(named: "cross", in: Bundle(for: self.classForCoder), compatibleWith: traitCollection) {
                faceCardImage.draw(in: bounds.zoom(by: 1))
                let tabGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(placeClickListner));
                self.addGestureRecognizer(tabGestureRecognizer)
            }
        case .CRICLE:
            if let faceCardImage = UIImage(named: "circle", in: Bundle(for: self.classForCoder), compatibleWith: traitCollection) {
                faceCardImage.draw(in: bounds.zoom(by: 1))
                let tabGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(placeClickListner));
                self.addGestureRecognizer(tabGestureRecognizer)
            }
        }
        
    }
    
    
    @objc func placeClickListner(tapRecongnizer: UITapGestureRecognizer) {
        player_sign = PLAYER_SIGN.CRICLE;
    }
    
}


extension CGRect {
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
}

