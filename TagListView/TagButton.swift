//
//  TagButton.swift
//  TagListViewDemo
//
//  Created by Hyun Seok Lee on 2016. 11. 3..
//  Copyright © 2016년 Ela. All rights reserved.
//

import UIKit

internal class TagButton: UIButton {
   
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    var borderColor: UIColor? {
        didSet {
            reloadStyles()
        }
    }
    
    var textColor: UIColor = UIColor.white {
        didSet {
            reloadStyles()
        }
    }
    var selectedTextColor: UIColor = UIColor.white {
        didSet {
            reloadStyles()
        }
    }
    var paddingY: CGFloat = 2 {
        didSet {
            titleEdgeInsets.top = paddingY
            titleEdgeInsets.bottom = paddingY
        }
    }
    var paddingX: CGFloat = 5 {
        didSet {
            titleEdgeInsets.left = paddingX
        }
    }
    
    var tagBackgroundColor: UIColor = UIColor.gray {
        didSet {
            reloadStyles()
        }
    }
    
    var highlightedBackgroundColor: UIColor? {
        didSet {
            reloadStyles()
        }
    }
    
    var selectedBorderColor: UIColor? {
        didSet {
            reloadStyles()
        }
    }
    
    var selectedBackgroundColor: UIColor? {
        didSet {
            reloadStyles()
        }
    }
    
    private func reloadStyles() {
        if isHighlighted {
            if let highlightedBackgroundColor = highlightedBackgroundColor {
                // For highlighted, if it's nil, we should not fallback to backgroundColor.
                // Instead, we keep the current color.
                backgroundColor = highlightedBackgroundColor
            }
        }
        else if isSelected {
            backgroundColor = selectedBackgroundColor ?? tagBackgroundColor
            layer.borderColor = selectedBorderColor?.cgColor ?? borderColor?.cgColor
            setTitleColor(selectedTextColor, for: .normal)
        }
        else {
            backgroundColor = tagBackgroundColor
            layer.borderColor = borderColor?.cgColor
            setTitleColor(textColor, for: .normal)
        }
    }
    
    override internal var isHighlighted: Bool {
        didSet {
            reloadStyles()
        }
    }
    
    override internal var isSelected: Bool {
        didSet {
            reloadStyles()
        }
    }

}
