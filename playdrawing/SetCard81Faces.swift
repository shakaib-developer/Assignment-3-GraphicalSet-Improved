//
//  SetCard81Faces.swift
//  SetCardGame
//
//  Created by Other develoeprs on 2/15/19.
//  Copyright © 2019 Other develoeprs. All rights reserved.
//

import Foundation
import UIKit


class  CardFaces {
    
    var facesArray = [(symbol: Int ,
                       countShape: Int,
                       shade: Int ,
                       color: Int)]()
    
    init( ) {
         
        for colorIndex in 1...3
        {
            for countIndex in 1...3
            {
                for shadeIndex in 1...3
                {
                    for  shapeIndex in 1...3
                    {
                        
                        facesArray.append((symbol: shapeIndex ,
                                                countShape: countIndex,
                                                shade:shadeIndex ,
                                                color: colorIndex ))
                        
                    }
                }
            }
        }
        
    }
    func randomCardFace() -> (
    
        symbol: Int  , countShape: Int, shade: Int  , color: Int )
    { 
        let rand = Int(arc4random_uniform(UInt32(self.facesArray.count - 1)))
        let attributes =  ( symbol: facesArray[rand].symbol,
            countShape: facesArray[rand].countShape,
            shade: facesArray[rand].shade,
            color: facesArray[rand].color)
         self.facesArray.remove(at: rand)
        return attributes
    }
    func isArrayEmpty() -> Bool {
        return facesArray.isEmpty
    }
}
