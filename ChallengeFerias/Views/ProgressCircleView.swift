//
//  ProgressViewCircle.swift
//  ChallengeFerias
//
//  Created by Juliana Vigato Pavan on 12/07/19.
//  Copyright © 2019 Juliana Vigato Pavan. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable

class ProgressCircleView: UIView{
    
    @IBInspectable
    var alegriaValue:CGFloat = 0.90 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var tristezaValue:CGFloat = 0.80 {
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var raivaValue:CGFloat = 0.70 {
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var medoValue:CGFloat = 0.60 {
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var aversaoValue:CGFloat = 0.50 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var circleWidth:CGFloat = 30.0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var circleColor:UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    
    @IBInspectable
    var alegriaColor:UIColor = #colorLiteral(red: 0.9921568627, green: 0.7333333333, blue: 0.02745098039, alpha: 1)
    
    @IBInspectable
    var tristezaColor:UIColor = #colorLiteral(red: 0.2274509804, green: 0.3882352941, blue: 0.6941176471, alpha: 1)
    
    @IBInspectable
    var raivaColor:UIColor = #colorLiteral(red: 0.6862745098, green: 0.1450980392, blue: 0.1843137255, alpha: 1)
    
    @IBInspectable
    var medoColor:UIColor = #colorLiteral(red: 0.4784313725, green: 0.2666666667, blue: 0.5725490196, alpha: 1)
    
    @IBInspectable
    var aversaoColor:UIColor = #colorLiteral(red: 0.2588235294, green: 0.6039215686, blue: 0.4588235294, alpha: 1)
    
    override func draw(_ rect: CGRect) {
        let fullCircle = CGFloat(2.0 * Double .pi)
        
        let startCircle:CGFloat = -0.25 * fullCircle
        
        let alegriaEnd:CGFloat = alegriaValue * fullCircle + startCircle
        
        let tristezaEnd:CGFloat = tristezaValue * fullCircle + startCircle
        
        let raivaEnd:CGFloat = raivaValue * fullCircle + startCircle
        
        let medoEnd:CGFloat = medoValue * fullCircle + startCircle
        
        let aversaoEnd:CGFloat = aversaoValue * fullCircle + startCircle
        
        let centerPoint = CGPoint(x: rect.midX, y: rect.midY)
        
        var radius:CGFloat = 0.0
        
        if rect.width < rect.height{
            radius = (rect.width - circleWidth) / 2.0
        }else {
            radius = (rect.height - circleWidth) / 2.0
        }
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setLineWidth(circleWidth)
        context?.setLineCap(CGLineCap.round)
        context?.setStrokeColor(self.circleColor.cgColor)
        context?.addArc(center: centerPoint, radius: radius, startAngle: 0, endAngle: fullCircle, clockwise: false)
        context?.strokePath()
        
        //Circulo da ALEGRIA
        context?.setStrokeColor(self.alegriaColor.cgColor)
        context?.addArc(center: centerPoint, radius: radius, startAngle: startCircle, endAngle: alegriaEnd, clockwise: false)
        context?.strokePath()
        
        //Circulo da TRISTEZA
        context?.setStrokeColor(tristezaColor.cgColor)
        context?.addArc(center: centerPoint, radius: radius, startAngle: startCircle, endAngle: tristezaEnd, clockwise: false)
        context?.strokePath()
        
        //Circulo da RAIVA
        context?.setStrokeColor(raivaColor.cgColor)
        context?.addArc(center: centerPoint, radius: radius, startAngle: startCircle, endAngle: raivaEnd, clockwise: false)
        context?.strokePath()
        
        //Circulo do MEDO
        context?.setStrokeColor(medoColor.cgColor)
        context?.addArc(center: centerPoint, radius: radius, startAngle: startCircle, endAngle: medoEnd, clockwise: false)
        context?.strokePath()
    
    
    //Circulo da AVERSAO
    context?.setStrokeColor(aversaoColor.cgColor)
    context?.addArc(center: centerPoint, radius: radius, startAngle: startCircle, endAngle: aversaoEnd, clockwise: false)
    context?.strokePath()
    }
    
}

