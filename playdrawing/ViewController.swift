//
//  ViewController.swift
//  SetCardGame
//
//  Created by Other develoeprs on 2/14/19.
//  Copyright © 2019 Other develoeprs. All rights reserved.
//


//index.()
struct Constants
{
    static let timeIntervel = 0.6
    static let cardRatio : CGFloat = 0.8
}
import UIKit

class ViewController: UIViewController ,traitFrameChange {
     lazy var animator = UIDynamicAnimator(referenceView: drawShapeOfSymbol )
    var cardsface = CardFaces()
    var cardlist  = [Int]()
    var cardWithFaces = 0
    var gameOfSet = SetCardGame()
    @IBOutlet weak var scoreLable: UILabel!
    
    @IBOutlet weak var drawShapeOfSymbol: MainView!{
        didSet{
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
            drawShapeOfSymbol.addGestureRecognizer(tap)
        }
    }
    //////////////////////----------------------------ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        drawShapeOfSymbol.frameChangeDelegate = self
        startNewGame()
    }
    
    //////////////////----------------------------staringScreen
    func startingScreen()
    {
       weak var timer : Timer?
        
        let numberOfCards = 12
        drawCardsFromDeck(byCountOf: numberOfCards)
        timer = Timer.scheduledTimer(withTimeInterval: Double(numberOfCards) * Constants.timeIntervel, repeats: false)
            {   timer in
                self.newGameStart.isEnabled = true
                self.newGameStart.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.deck.isEnabled = true
        }
    }
    func drawCardsFromDeck(byCountOf count : Int)
    {  weak var timer : Timer?
        var grid = Grid(layout: Grid.Layout.aspectRatio(Constants.cardRatio ),frame:drawShapeOfSymbol.bounds)
        grid.cellCount = cardWithFaces + count
        ///////////count is alomst every time 3
        for index in 0...count-1
        {
            timer = Timer.scheduledTimer(withTimeInterval: Constants.timeIntervel * Double(index),repeats: false)
            {
                timer in
                grid.frame = self.drawShapeOfSymbol.bounds
                self.drawOneCardFromDeck( frameGrid: grid[self.cardWithFaces ]!)///////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
            }
        }
    }
    //------------------------------------------------------removeSet
    func removeSet(of index: Int)
    {
        weak var timer : Timer?
        var discardedDeckFrame = self.scoreLable.frame
        
        discardedDeckFrame.origin = CGPoint(
            x: drawShapeOfSymbol.bounds.maxX  - scoreLable.frame.size.width ,
            y:  drawShapeOfSymbol.bounds.maxY)
        
        drawShapeOfSymbol.frameOfCard(at: index, discardedDeckFrame)
        timer = Timer.scheduledTimer(withTimeInterval: Constants.timeIntervel, repeats: false)
        {timer in
            self.drawShapeOfSymbol.cardDraw[index].removeFromSuperview()
        }}
     ///////////////---------------------------drawOneCardFromDeck()@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    func drawOneCardFromDeck(  frameGrid : CGRect)
    {
          if(!cardsface.isArrayEmpty() ){
            let index = cardWithFaces
            AttributingCardFaces( index : index)
            cardWithFaces += 1
            drawShapeOfSymbol.frameOfBlankCard(at: index, frameGrid, deckFrame: deck.frame)
            drawShapeOfSymbol.addCardAsSubview(at: index, frameGrid)
        }
    }
    
    ////
    func  changingSetOfCards(_ cardlist: [Int],framesOfMatchedCards: [CGRect] )
    {
        weak var timer : Timer?
        var deleteIndicator = 0
  /////need to ask the approach
        for indexOfList in 0...2
        {   let index = cardlist[indexOfList]

            timer = Timer.scheduledTimer(withTimeInterval: Constants.timeIntervel * Double(indexOfList), repeats: false)
            { timer in
                
                self.removeSet(of : index)
            }
        }
        if !cardsface.isArrayEmpty()
        {
            for indexOfList in 0...2
            {  // let index = cardlist[indexOfList]
                timer = Timer.scheduledTimer(withTimeInterval: 2 + (Constants.timeIntervel * Double(indexOfList)), repeats: false)
                {
                    timer in
                    self.drawOneCardFromDeck(  frameGrid :framesOfMatchedCards[indexOfList])
                }
            }
        }
        else
        {
            timer = Timer.scheduledTimer(withTimeInterval: Constants.timeIntervel * 3 , repeats: false)
            { timer in
                
                self.deleteCards(cardlist)
            }
        }
        timer = Timer.scheduledTimer(withTimeInterval: Constants.timeIntervel * 6 , repeats: false)
        {timer in
            
            self.deck.isEnabled = true
            self.newGameStart.isEnabled = true
        }
        
    }
    @IBOutlet weak var newGameStart: UIButton!
    /////////--------------------------------------------updateView
    func  updateView(selectionResult  result : Bool)
        
    {     scoreLable.text = "Score: \(gameOfSet.score)"
        for index in  0...2
        {
        drawShapeOfSymbol.cardSelection(click: false, on: cardlist[index])///////
        }
        if result
        {
//            if
//                !cardsface.isArrayEmpty() || 1==1 //, cardWithFaces > 3
//            {
                var cardlists = cardlist
                var framesOfMatchedCards = [CGRect]()
                deck.isEnabled = false
                newGameStart.isEnabled = false
                
                for indexOfList in 0...2
                {
                    let index = cardlist[indexOfList]
                    framesOfMatchedCards.append(self.drawShapeOfSymbol.cardDraw[index].frame)
                    Behavior(cards: drawShapeOfSymbol.cardDraw[index] )
                 }
                weak var timer : Timer?
                timer = Timer.scheduledTimer(
                    withTimeInterval: 1,
                    repeats: false)
                { timer in
                    self.animator.removeAllBehaviors()
                    self.changingSetOfCards(cardlists,framesOfMatchedCards: framesOfMatchedCards)
                }
                
//            }
//            else
//            {
            
//                 for index in 0...2
//                {
//                    let max = cardlist.max()!
//                        self.drawShapeOfSymbol.cardDraw.remove(at: max)
//                         self.defineCardFrame()
//                     cardlist[ cardlist.firstIndex(of: max)!] = -1
//                }
//                cardWithFaces -= 3
               // defineCardFrame()
//            }
        }
      }
    func deleteCards( _ cardList: [Int]){
        var listOfCard =  cardList
        for _ in 0...2 {
        let max = listOfCard.max()!
        self.drawShapeOfSymbol.cardDraw.remove(at: max)
             cardWithFaces -= 1
       listOfCard[ listOfCard.firstIndex(of: max)!] = -1
        }
        defineCardFrame()
 
    }
    //    ///////////////////////////////--------------cardSelection
    @IBAction func DealOf3CardSet(_ sender: UIButton) {
        deck.isEnabled = false
        deck.backgroundColor =  #colorLiteral(red: 0.5128239913, green: 0.501409506, blue: 0.5141775063, alpha: 1)
           Deal3MoreCards()
        weak var timer : Timer?
        timer = Timer.scheduledTimer(
            withTimeInterval: Constants.timeIntervel * 3,
            repeats: false){
                timer in
                self.deck.isEnabled = true
                self.deck.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)                }
    }
    ///////////////////////////////--------------------Deal3MoreCards
        func Deal3MoreCards() {
            
            addNewCards(ofCount: 3 )
            drawCardsFromDeck(byCountOf: 3 )
    }
    func addNewCards(ofCount count: Int)
    {
        var grid = Grid(layout: Grid.Layout.aspectRatio(Constants.cardRatio ) ,
                        frame: drawShapeOfSymbol.bounds)
        grid.cellCount = cardWithFaces + count
        for index in 0...cardWithFaces - 1
        {
            drawShapeOfSymbol.addCardAsSubview(at: index,  grid[index]!)
        }
    }
    
    @IBOutlet weak var deck: UIButton!
  
    //////////--------------------------------------cardFrame
    func defineCardFrame() {
        
        var grid = Grid(layout: Grid.Layout.aspectRatio(Constants.cardRatio ) ,
                        frame: drawShapeOfSymbol.bounds)
        grid.cellCount = cardWithFaces
        
        for index in 0...cardWithFaces - 1
        {
            drawShapeOfSymbol.addCardAsSubview(at: index, grid[index]!)
         }
    }
    ////===
    func startNewGame()
    {
        
        cardlist.removeAll()
        gameOfSet = SetCardGame()
        cardWithFaces = 0
        cardsface = CardFaces()
        for subUIView in drawShapeOfSymbol.subviews
        {
            subUIView.removeFromSuperview()
        }
        drawShapeOfSymbol.cardDraw.removeAll()
        scoreLable.text = "Score: 0"
     startingScreen()
    }
    ////===
    
    //    ///////////////////////////////------btn---------------newGame
    @IBAction func newGame(_ sender: UIButton) {
        deck.isEnabled = false
        newGameStart.isEnabled = false
        newGameStart.backgroundColor = #colorLiteral(red: 0.5128239913, green: 0.501409506, blue: 0.5141775063, alpha: 1)
        startNewGame()
    }
    ///////
    
    //////////////////----------------------------------------changeSubviewBounds
    func changeSubviewBounds( frame : CGRect)
    {
        if cardWithFaces > 0
        {
            var grid = Grid(layout: Grid.Layout.aspectRatio(Constants.cardRatio ) , frame: frame )
            grid.cellCount = cardWithFaces
            
            for index in 0...cardWithFaces - 1
            {
                drawShapeOfSymbol.frameOfCard(at: index, grid[index]!)
            }
        }
    }
    ////////////---------------------------------tapFunction
    @objc func tapFunction(_ sender: UITapGestureRecognizer){
        
        let loc = sender.location(in: sender.view)
        let firstHitView =  drawShapeOfSymbol.cardDraw.first(where: {
            (loc.x > $0.frame.origin.x && loc.y > $0.frame.origin.y) &&
                (loc.x < ($0.frame.origin.x + $0.bounds.width)) &&
                (loc.y < ($0.frame.origin.y + $0.bounds.height)) }  )
        
        if let cardNumber = drawShapeOfSymbol.cardDraw.firstIndex(of: firstHitView ?? SketchOfSymbols())
        {
            if cardlist.filter({$0 == cardNumber}).isEmpty
            {
                if cardlist.count < 3
                {
                     cardlist.append(cardNumber)
                     drawShapeOfSymbol.cardSelection(click: true, on: cardNumber)
                }
                else
                {
                    checkSet()
                }
            }
            else
            {
                cardlist.remove(at: cardlist.firstIndex(of: cardNumber)!)
                drawShapeOfSymbol.cardSelection(click: false, on: cardNumber)
            }
        }
    }
    
    //////////////////////////////////---------------------checkSet
    func checkSet()
    {
        for index in 0...2
        {
            let index = cardlist[index]
            gameOfSet.chooseCardSet(
                symbol: drawShapeOfSymbol.cardDraw[index].symbol ,
                countShape: drawShapeOfSymbol.cardDraw[index].countShape ,
                shade: drawShapeOfSymbol.cardDraw[index].shade,
                color: drawShapeOfSymbol.cardDraw[index].color  )
        }
        updateView(selectionResult : gameOfSet.CheckSetOfCards())
        cardlist.removeAll()
    }
    
    
    ///////////////-------------------------------------swip3MoreCards
 
    //////////--------------------------------------drawCardFaces
    func AttributingCardFaces (index : Int) {
        
        if(!cardsface.isArrayEmpty())
        {
            let attributes = cardsface.randomCardFace()
            drawShapeOfSymbol.cardDraw.append(SketchOfSymbols())
            
            drawShapeOfSymbol.cardDraw[index].setData(
                symbol: attributes.symbol,
                countShape:  attributes.countShape,
                shade:  attributes.shade,
                color:  attributes.color)
        }
    }
    func Behavior(cards : UIView){
        drawShapeOfSymbol.bringSubviewToFront(cards)
        let card =   UIDynamicItemBehavior()
        card.elasticity = 1.0
        card.resistance = 0.0
        card.allowsRotation = true
        let cardElasticity = UICollisionBehavior()
        cardElasticity.translatesReferenceBoundsIntoBoundary = true
        let push = UIPushBehavior(items: [cards], mode: .instantaneous)
        push.angle = CGFloat(Int.random(in: 1...360))
        push.magnitude = 20.0
        card.addItem(cards)
        cardElasticity.addItem(cards)
        let  behavior = UIDynamicBehavior()
        
        behavior.addChildBehavior(push)
        behavior.addChildBehavior(card)
        behavior.addChildBehavior(cardElasticity)
        animator.addBehavior(behavior)
        push.action = { [unowned push] in behavior.removeChildBehavior(push)}
    }

}
//
//
///disable button deck when starting screen
///
///0o0909
