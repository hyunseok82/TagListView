//
//  TagView.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

@IBDesignable
public class TagView: UIView {

    // MARK: tag button
    
    let tagButton = TagButton()
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            tagButton.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            tagButton.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var borderColor: UIColor? {
        didSet {
            tagButton.borderColor = borderColor
        }
    }
    
    @IBInspectable public var textColor: UIColor = UIColor.whiteColor() {
        didSet {
            tagButton.textColor = textColor
        }
    }
    @IBInspectable public var selectedTextColor: UIColor = UIColor.whiteColor() {
        didSet {
            tagButton.selectedTextColor = selectedTextColor
        }
    }
    @IBInspectable public var paddingY: CGFloat = 2 {
        didSet {
            tagButton.paddingY = paddingY
        }
    }
    @IBInspectable public var paddingX: CGFloat = 5 {
        didSet {
            tagButton.paddingX = paddingX
            updateRightInsets()
        }
    }

    @IBInspectable public var tagBackgroundColor: UIColor = UIColor.grayColor() {
        didSet {
            tagButton.tagBackgroundColor = tagBackgroundColor
        }
    }
    
    @IBInspectable public var highlightedBackgroundColor: UIColor? {
        didSet {
            tagButton.highlightedBackgroundColor = highlightedBackgroundColor
        }
    }
    
    @IBInspectable public var selectedBorderColor: UIColor? {
        didSet {
            tagButton.selectedBorderColor = selectedBorderColor
        }
    }
    
    @IBInspectable public var selectedBackgroundColor: UIColor? {
        didSet {
            tagButton.selectedBackgroundColor = selectedBackgroundColor
        }
    }
    
    var textFont: UIFont = UIFont.systemFontOfSize(12) {
        didSet {
            tagButton.titleLabel?.font = textFont
        }
    }
    
    var tagSelected: Bool {
        set {
            tagButton.selected = tagSelected
        }
        get {
            return tagButton.selected
        }
    }
    
    var currentTitle: String? {
        return tagButton.currentTitle
    }
    
    // MARK: remove button
    
    let removeButton = CloseButton()
    
    @IBInspectable public var enableRemoveButton: Bool = false {
        didSet {
            removeButton.hidden = !enableRemoveButton
            updateRightInsets()
        }
    }
    
    @IBInspectable public var removeButtonIconSize: CGFloat = 12 {
        didSet {
            removeButton.iconSize = removeButtonIconSize
            updateRightInsets()
        }
    }
    
    @IBInspectable public var removeIconLineWidth: CGFloat = 3 {
        didSet {
            removeButton.lineWidth = removeIconLineWidth
        }
    }
    
    @IBInspectable public var removeIconLineColor: UIColor = UIColor.whiteColor().colorWithAlphaComponent(0.54) {
        didSet {
            removeButton.lineColor = removeIconLineColor
        }
    }
    
    @IBInspectable public var removeIconImage: UIImage? {
        didSet {
            removeButton.iconImage = removeIconImage
            updateRightInsets()
        }
    }
    
    /// Handles Tap (TouchUpInside)
    public var onTap: ((TagView) -> Void)?
    public var onLongPress: ((TagView) -> Void)?
    
    // MARK: - init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    public init(title: String) {
        super.init(frame: CGRectZero)
        tagButton.setTitle(title, forState: .Normal)
        
        setupView()
    }
    
    private func setupView() {
        frame.size = intrinsicContentSize()
        addSubview(tagButton)
        addSubview(removeButton)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        self.addGestureRecognizer(longPress)
    }
    
    func longPress() {
        onLongPress?(self)
    }
    
    // MARK: - layout

    private func updateRightInsets() {
        if enableRemoveButton && removeIconImage == nil {
            tagButton.titleEdgeInsets.right = paddingX  + removeButtonIconSize + paddingX
        }
        else {
            tagButton.titleEdgeInsets.right = paddingX
        }
    }
    
    override public func intrinsicContentSize() -> CGSize {
        var size = tagButton.titleLabel?.text?.sizeWithAttributes([NSFontAttributeName: textFont]) ?? CGSizeZero
        size.height = textFont.pointSize + paddingY * 2
        size.width += paddingX * 2
        if enableRemoveButton {
            size.width += removeButtonIconSize + paddingX
        }
        return size
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        tagButton.frame = self.frame
        
        if enableRemoveButton {
            if removeIconImage == nil {
                removeButton.frame.size.width = paddingX + removeButtonIconSize + paddingX
                removeButton.frame.origin.x = self.frame.width - removeButton.frame.width
                removeButton.frame.size.height = self.frame.height
                removeButton.frame.origin.y = 0
            } else {
                tagButton.frame.size.width = self.frame.width - (removeButtonIconSize + paddingX)
                removeButton.frame.size.width = removeButtonIconSize
                removeButton.frame.size.height = removeButtonIconSize
                removeButton.frame.origin.x = self.frame.width - removeButton.frame.width - (paddingX / 2)
                removeButton.frame.origin.y = (self.frame.height - removeButton.frame.height) / 2
            }
        }
    }
}
