//
//  ColorSeletcionView.swift
//  CatchIdea
//
//  Created by Linsw on 16/12/30.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

class ColorSeletcionView: UIView {

    internal var selectionDelegate: ColorSelectionDelegate?

    private var currentSelectedButton: UIButton? {
        didSet{
            if let oldButton = oldValue {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: { Void in
                    oldButton.transform = .identity
                }, completion: nil)
            }
            buttonRingLayer.removeFromSuperlayer()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: {[weak self] Void in
                if let safeSelf = self {
                    safeSelf.currentSelectedButton?.transform = CGAffineTransform(scaleX: safeSelf.animateScale, y: safeSelf.animateScale)
                }
            }, completion: nil)
            currentSelectedButton?.layer.addSublayer(buttonRingLayer)
            
        }
    }
    
    private let buttonSideLength: CGFloat = 20
    private let animateScale: CGFloat = 1.3
    
    private var buttonRingLayer = CALayer()
    private var buttons = [UIButton]()
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = Theme.shared.mainThemeColor
        
        buttonRingLayer.frame = CGRect(x: -2, y: -2, width: buttonSideLength+4, height: buttonSideLength+4)
        buttonRingLayer.cornerRadius = buttonRingLayer.frame.width/2
        buttonRingLayer.borderColor = UIColor.lightGray.cgColor
        buttonRingLayer.borderWidth = 2
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
        addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
        addGestureRecognizer(panGesture)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initButtons(withContainerViewFrame: frame)
    }

    private func initButtons(withContainerViewFrame containerViewFrame: CGRect){
        guard buttons.count == 0 else {return}
        let sideSpace: CGFloat = 20
        let buttonSize = CGSize(width: buttonSideLength, height: buttonSideLength)
        let buttonCount: CGFloat = 7
        let buttonGap = (containerViewFrame.width-buttonCount*buttonSize.width-sideSpace*2)/(buttonCount-1)
        
        for index in 0...Int(buttonCount)-1 {
            //button.frame.origin.y = 0 使button在View的顶部位置。
            let button = UIButton(frame: CGRect(origin: CGPoint(x: 20+(buttonSize.width+buttonGap)*CGFloat(index),y: 0), size: buttonSize))
            if index == 0 {
                button.backgroundColor = UIColor.white
            }else{
                button.backgroundColor = Theme.shared.markColors[index-1]
            }
            button.layer.cornerRadius = button.frame.width/2
            button.isUserInteractionEnabled = false
            addSubview(button)
            buttons.append(button)
        }
        currentSelectedButton = buttons[0]
    }
    
    
    @objc private func didTap(sender: UITapGestureRecognizer) {
        selectButton(atPoint: sender.location(in: self))
    }
    
    @objc private func didPan(sender: UIPanGestureRecognizer) {
        selectButton(atPoint: sender.location(in: self))
    }
    
    private func selectButton(atPoint point: CGPoint) {
        for btn in buttons {
            if fabs(btn.center.x - point.x) < buttonSideLength/2 {
                guard currentSelectedButton != btn else { return }
                currentSelectedButton = btn
                selectionDelegate?.didSelectColor(btn.backgroundColor!)
                break
            }
        }
    }
}
