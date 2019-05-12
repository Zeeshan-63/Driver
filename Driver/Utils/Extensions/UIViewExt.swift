
import Foundation
import UIKit

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func applyGradient(colors: [CGColor])
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addCurve(headerColor: UIColor) {
        
        let path = UIBezierPath()
        let cpoint1 = CGPoint(x: self.frame.width/4, y: self.frame.height/4)
        let cpoint2 = CGPoint(x: self.frame.width*3/4, y: self.frame.height + self.frame.height/4)
        path.move(to:.init(x: 0, y: 0))
        path.addLine(to:.init(x: 0, y: self.frame.height - self.frame.height/4))
        path.addCurve(to: .init(x: self.frame.width + self.frame.height/4, y: self.frame.height - self.frame.height/4), controlPoint1: cpoint1, controlPoint2: cpoint2)
        path.addLine(to: CGPoint(x: self.frame.width + self.frame.height/4, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.reversing().cgPath
        shapeLayer.fillColor = headerColor.cgColor
        shapeLayer.strokeColor =  headerColor.cgColor
        shapeLayer.lineWidth = 1.0
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func addCurveWithGradient(headerColors: [CGColor]) {
        
        let headerColor = UIColor.red
        let path = UIBezierPath()
        let cpoint1 = CGPoint(x: self.frame.width/4, y: self.frame.height/4)
        let cpoint2 = CGPoint(x: self.frame.width*3/4, y: self.frame.height + self.frame.height/4)
        path.move(to:.init(x: 0, y: 0))
        path.addLine(to:.init(x: 0, y: self.frame.height - self.frame.height/4))
        path.addCurve(to: .init(x: self.frame.width + self.frame.height/4, y: self.frame.height - self.frame.height/4), controlPoint1: cpoint1, controlPoint2: cpoint2)
        path.addLine(to: CGPoint(x: self.frame.width + self.frame.height/4, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.reversing().cgPath
        shapeLayer.fillColor = headerColor.cgColor
        shapeLayer.strokeColor =  headerColor.cgColor
        shapeLayer.lineWidth = 1.0
        
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = headerColors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.mask = shapeLayer
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
