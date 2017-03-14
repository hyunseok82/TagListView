//
//  CloseButton.swift
//  TagListViewDemo
//
//  Created by Benjamin Wu on 2/11/16.
//  Copyright © 2016 Ela. All rights reserved.
//

import UIKit

internal class CloseButton: UIButton {
    
    var iconSize: CGFloat = 10
    var lineWidth: CGFloat = 1
    var lineColor: UIColor = UIColor.white.withAlphaComponent(0.54)
    var iconImage: UIImage? {
        didSet {
            self.setBackgroundImage(iconImage, for: .normal)
        }
    }
  
    override func draw(_ rect: CGRect) {
        guard iconImage == nil else {
            super.draw(rect)
            return
        }
       
        let path = UIBezierPath()
        
        path.lineWidth = lineWidth
        path.lineCapStyle = .round

        let iconFrame = CGRect(
            x: (rect.width - iconSize) / 2.0,
            y: (rect.height - iconSize) / 2.0,
            width: iconSize,
            height: iconSize
        )

        path.move(to: iconFrame.origin)
        path.addLine(to: CGPoint(x: iconFrame.maxX, y: iconFrame.maxY))
        path.move(to: CGPoint(x: iconFrame.maxX, y: iconFrame.minY))
        path.addLine(to: CGPoint(x: iconFrame.minX, y: iconFrame.maxY))

        lineColor.setStroke()
        
        path.stroke()
    }
    
}
