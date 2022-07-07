//
//  UIView+Extension.swift
//  LabTest
//
//  Created by Wong Tian Haw on 06/07/2022.
//

import UIKit

extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
            
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func makeBottomView() {
        backgroundColor = .white
        layer.cornerRadius = 35
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOffset = CGSize(width: -4, height: -6)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 20
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addGradient(colors: [UIColor] = [.blue, .white], locations: [NSNumber] = [0, 2], startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0), type: CAGradientLayerType = .axial){
        
        let gradient = CAGradientLayer()
        
        gradient.frame.size = self.frame.size
        //        gradient.frame.origin = CGPoint(x: 0.0, y: 0.0)
        
        // Iterates through the colors array and casts the individual elements to cgColor
        // Alternatively, one could use a CGColor Array in the first place or do this cast in a for-loop
        gradient.colors = colors.map{ $0.cgColor }
        
        //        gradient.locations = locations
        //        gradient.startPoint = startPoint
        //        gradient.endPoint = endPoint
        
        // Insert the new layer at the bottom-most position
        // This way we won't cover any other elements
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func makeGradient(startPoint: CAGradientLayer.Point, endPoint: CAGradientLayer.Point, colors: [CGColor], type: CAGradientLayerType) {
        let gradientLayer = CAGradientLayer(start: startPoint, end: endPoint, colors: colors, type: type)
        gradientLayer.frame = self.bounds
        self.clipsToBounds = true
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //Draw Dash
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView, color: UIColor? = .white) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color?.cgColor
        shapeLayer.lineWidth = 0.5
        shapeLayer.lineDashPattern = [4, 4] // 7 is the length of dash, 3 is length of the gap.
        
        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
    
    func setupCommonBottomViewUI(){
        backgroundColor = .white
        layer.cornerRadius = 30
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOffset = CGSize(width: -4, height: -6)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 20
    }
    
    func setupBottomMainViewUI() {
        clipsToBounds = true
        layer.cornerRadius = 30
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
    }
    
    func isEnable(_ isEnable: Bool){
        isUserInteractionEnabled = isEnable
        backgroundColor = isEnable ? .white : .green
    }
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    enum ViewSide: String {
        case left = "Left", right = "Right", top = "Top", bottom = "Bottom", all = "All"
    }
    
    func drawBorder(edges: [ViewSide], borderWidth: CGFloat, color: UIColor, margin: CGFloat = 0.0) {
        for item in edges {
            let borderLayer: CALayer = CALayer()
            borderLayer.name = item.rawValue
            borderLayer.borderColor = color.cgColor
            borderLayer.borderWidth = borderWidth
            switch item {
            case .top:
                borderLayer.frame = CGRect(x: margin, y: 0, width: frame.width - (margin*2), height: borderWidth)
            case .left:
                borderLayer.frame =  CGRect(x: 0, y: margin, width: borderWidth, height: frame.height - (margin*2))
            case .bottom:
                borderLayer.frame = CGRect(x: margin, y: frame.height - borderWidth, width: frame.width - (margin*2), height: borderWidth)
            case .right:
                borderLayer.frame = CGRect(x: frame.width - borderWidth, y: margin, width: borderWidth, height: frame.height - (margin*2))
            case .all:
                drawBorder(edges: [.top, .left, .bottom, .right], borderWidth: borderWidth, color: color, margin: margin)
            }
            self.layer.addSublayer(borderLayer)
        }
    }
    
    func removeBorder(toSide side: ViewSide) {
        guard let sublayers = self.layer.sublayers else { return }
        var layerForRemove: CALayer?
        for layer in sublayers {
            if layer.name == side.rawValue {
                layerForRemove = layer
            }
        }
        if let layer = layerForRemove {
            layer.removeFromSuperlayer()
        }
    }
    
    func fadeIn(_ duration: TimeInterval? = 0.2, onCompletion: (() -> Void)? = nil) {
        self.alpha = 0
        self.isHidden = false
        UIView.animate(withDuration: duration!,
                       animations: { self.alpha = 1 },
                       completion: { (value: Bool) in
            if let complete = onCompletion { complete() }
        }
        )
    }
    
    func fadeOut(_ duration: TimeInterval? = 0.2, onCompletion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration!,
                       animations: { self.alpha = 0 },
                       completion: { (value: Bool) in
            self.isHidden = true
            if let complete = onCompletion { complete() }
        }
        )
    }
}


extension CAGradientLayer {
    enum Point {
        case topLeft
        case centerLeft
        case bottomLeft
        case topCenter
        case center
        case bottomCenter
        case topRight
        case centerRight
        case bottomRight
        var point: CGPoint {
            switch self {
            case .topLeft:
                return CGPoint(x: 0, y: 0)
            case .centerLeft:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeft:
                return CGPoint(x: 0, y: 1.0)
            case .topCenter:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottomCenter:
                return CGPoint(x: 0.5, y: 1.0)
            case .topRight:
                return CGPoint(x: 1.0, y: 0.0)
            case .centerRight:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomRight:
                return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }
    convenience init(start: Point, end: Point, colors: [CGColor], type: CAGradientLayerType) {
        self.init()
        self.startPoint = start.point
        self.endPoint = end.point
        self.colors = colors
        self.locations = (0..<colors.count).map(NSNumber.init)
        self.type = type
    }
}
