//
//  drawShape.swift
//  playdrawing
//
//  Created by Other develoeprs on 2/21/19.
//  Copyright © 2019 Other develoeprs. All rights reserved.
//

import UIKit
protocol traitFrameChange {
    func changeSubviewBounds( frame : CGRect)
}

class MainView: UIView {
    var frameChangeDelegate : traitFrameChange!
   
    var cardDraw = [SketchOfSymbols]()
    override func draw(_ rect: CGRect) {
        frameChangeDelegate.changeSubviewBounds(frame : self.bounds)
     }
 
    func addCardAsSubview (at index : Int,_ frame : CGRect)
    { 
       frameOfCard(at: index, frame)
          addSubview(cardDraw[index])
         cardDraw[index].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
    //////////-------------
    func frameOfCard (at index : Int,_ frame : CGRect)
    {
        if cardDraw.count > index{
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.6,
            delay: 0.1,
            options: [.transitionFlipFromLeft],
            animations: {
                self.cardDraw[index].frame = frame
        })
        }
    }
    //////////////////--------------------
    func frameOfBlankCard (at index : Int,_ frame : CGRect, deckFrame : CGRect)
    {
        if cardDraw.count > index
        {
            let fakeCard = UIView()
            
            addSubview(fakeCard)
            fakeCard.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            fakeCard.frame = deckFrame
            fakeCard.frame.origin = CGPoint(x: bounds.minX, y: bounds.maxY  )
            cardDraw[index].alpha = 0
            UIViewPropertyAnimator.runningPropertyAnimator(
                withDuration: 0.6,
                delay: 0.1,
                options: [.transitionFlipFromLeft],
                animations: {
                    fakeCard.frame = frame
                    
            }
                , completion: {pos in
                    if self.cardDraw.count > index
                    {
                        UIView.transition(
                            with: self.cardDraw[index],
                            duration: 0.6,
                            options: [.transitionFlipFromLeft],
                            animations: {
                                self.cardDraw[index].alpha = 1
                                fakeCard.alpha = 0
                        } )
                    }
            } )
        }
    }
    //    ///////////////////////////////--------------cardSelection
    func cardSelection ( click yes : Bool,on index : Int) {
        
        if yes
        {
            cardDraw[index].backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        else
        {
            cardDraw[index].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
    }

    
    //      @objc func pinchFunction (HandlingPinch recognize:  UIPinchGestureRecognizer)
    //    {
    //        print("working ")
    //        switch recognize.state
    //        {
    //        case .changed,.ended :
    //            print("working ")
    //            var frameArray : [CGRect] = []
    //            let count = cardDraw.count-1
    //            for index in 0...count
    //            {
    //                frameArray.append(cardDraw[index].frame)
    //            }
    //            for index in 0...count
    //            {
    //                let rand = Int(arc4random_uniform(UInt32(frameArray.count)))
    //                cardDraw[index].frame = frameArray[rand]
    //                frameArray.remove(at: rand)
    //            }
    //
    //        default: break
    //        }
    //
    //
    //    }
}



