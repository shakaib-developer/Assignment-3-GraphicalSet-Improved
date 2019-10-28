 
 
 import UIKit
 class SketchOfSymbols: UIView {
    
 
   private(set) var symbol : Int = 0
   private(set) var countShape : Int = 0
   private(set) var shade : Int = 0
   private(set) var color : Int = 0
 
private    func shading(on path  : UIBezierPath)
    {
        for i in 1...Int(Int(bounds.maxX)/7)
    {
        path.move(to: CGPoint(x:  CGFloat(i*7) , y: bounds.minY))
        path.addLine(to: CGPoint(x: CGFloat(i*7), y: bounds.maxY))
        
        }
    }
    //////
    override init(frame: CGRect) {
        super.init(frame: frame) }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     func setData(symbol: Int ,  countShape: Int, shade: Int ,  color: Int)
    {
         self.symbol = symbol
         self.countShape = countShape
         self.shade  = shade
         self.color  = color
    }
    
    func DrawShape(on path  : UIBezierPath) {
        var colorOfView : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        switch symbol   {
        case  1: drawOval(on: path)
        case  2: drawDiamond(on: path)
        case  3: drawSquiggle(on: path)
        default: break
        }
        switch color {
        case 1: colorOfView = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        case 2: colorOfView = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        case 3: colorOfView = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
        default:
            break
        }
        
        switch shade {
        case 1:
            shading(on : path)
            path.addClip()
        case 2:
            colorOfView .setFill()
            path.fill()
        default:
            break
        }
        
        colorOfView .setStroke()
        path.lineWidth = 2
        path.stroke()
       }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        //DrawShape1(on: path)
        DrawShape(on: path)
        path.lineWidth = 2
        path.stroke()
    }
    func  DrawShape1( on : UIBezierPath)
    {}
   private func drawOval(on path : UIBezierPath){
        for index in 0...countShape - 1
        {
            let i = CGFloat(index)*0.25
            path.move(to: CGPoint(x: bounds.maxX*(0.10)  ,y: bounds.maxY*(0.25+i)))
            ////upper curve
            path.addCurve(to: CGPoint(x: bounds.maxX*(0.9) ,y: bounds.maxY*(0.25+i) ),
                          controlPoint1: CGPoint(x: bounds.maxX*(0.10), y: bounds.maxY*(0.10+i) ),
                          controlPoint2: CGPoint(x: bounds.maxX*(0.90), y: bounds.maxY*(0.10+i)  ))
            ////under curve
            path.addCurve(to: CGPoint(x: bounds.maxX*(0.10) ,y: bounds.maxY*(0.25+i) ),
                          controlPoint1:CGPoint(x: bounds.maxX*(0.90) , y: bounds.maxY*(0.40+i) ),
                          controlPoint2:CGPoint(x: bounds.maxX*(0.10) , y: bounds.maxY*(0.40+i) ) )
         }
       
    }
   private func drawDiamond(on path  : UIBezierPath) {
        for index in 0...countShape - 1
        {
            let i = CGFloat(index)*0.30
            path.move(to: CGPoint(x: bounds.midX ,y: bounds.maxY*(0.05+i) ))
            path.addLine(to: CGPoint(x:  bounds.maxX*(0.10),y: bounds.maxY*(0.18+i)))
            
            path.addLine(to: CGPoint(x: bounds.midX ,y: bounds.maxY*(0.31+i) ))
            
            path.addLine(to: CGPoint(x: bounds.maxX*0.9 ,y: bounds.maxY*(0.18+i) ))
            path.close()
        }
    }

   private func drawSquiggle(on path  : UIBezierPath) {
        for index in 0...countShape - 1
        {
            let i = CGFloat(index)*0.30
            
            path.move(to: CGPoint(x: bounds.maxX*(0.10) ,y: bounds.maxY*(0.35+i) ))
            
            path.addCurve(to: CGPoint(x: bounds.maxX*(0.90) ,y: bounds.maxY*(0.10+i)) ,// + 2 ),
                controlPoint1: CGPoint(x: bounds.maxX*(0.01) , y: bounds.maxY*(0.01+i)),
                controlPoint2: CGPoint(x: (bounds.maxX*(0.90) ), y: (bounds.maxY*(0.35+i) )))
            
            path.addCurve(to: CGPoint(x: bounds.maxX*(0.10) /*+ 2  */,y: bounds.maxY*(0.35+i) ),
                          controlPoint1: (CGPoint(x: bounds.maxX*(0.90) , y: bounds.maxY*(0.50+i) )),
                          controlPoint2: CGPoint(x: bounds.maxX*(0.10) , y: bounds.maxY*(0.175+i)  ))
        }
    }
    
 }
 
