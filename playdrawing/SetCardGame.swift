//
//  SetCardGame.swift
//  SetCardGame
//
//  Created by Other develoeprs on 2/15/19.
//  Copyright © 2019 Other develoeprs. All rights reserved.
//

import Foundation
import UIKit
class SetCardGame
{
    
    var score : Int = 0
    
   private var checkSymbol = Set<Int>()
   private var checkShade  = Set<Int>()
   private var checkCount  = Set<Int>()
   private var checkColor  = Set<Int>()
    ///////////////////////-----------chooseCardSet
    func chooseCardSet(
        symbol: Int ,
        countShape: Int,
        shade: Int ,
        color: Int
        )
    {  checkSymbol.insert(symbol)
        checkCount.insert(countShape)
        checkShade.insert(shade)
        checkColor.insert(color)
    }
   func CheckSetOfCards() -> Bool
    {
        var result  = false
        score -= 1
        
        if    checkSymbol.count != 2 ,
            checkCount.count != 2 ,
            checkShade.count != 2 ,
            checkColor.count != 2
        {
            score += 4
            result = true
        }
        setClear()
        return result
    }
    
 private   func setClear()
    {
        checkSymbol.removeAll()
        checkShade.removeAll()
        checkCount.removeAll()
        checkColor.removeAll()
    }
    
}
