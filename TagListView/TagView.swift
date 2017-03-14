//
//  TagView.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

@IBDesignable
open class TagView: UIView {

    // MARK: tag button
    let tagButton = TagButton()
    
    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            tagButton.cornerRadius = cornerRadius
        }
    }

    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet {
            tagButton.borderWidth = borderWidth
        }
    }
    
    @IBInspectable open var borderColor: UIColor? {
        didSet {
            tagButton.borderColor = borderColor
        }
    }
    
    @IBInspectable open var textColor: UIColor = UIColor.white {
        didSet {
            tagButton.textColor = textColor
        }
    }
    @IBInspectable open var selectedTextColor: UIColor = UIColor.white {
        didSet {
            tagButton.selectedTextColor = selectedTextColor
        }
    }
    @IBInspectable open var paddingY: CGFloat = 2 {
        didSet {
            tagButton.paddingY = paddingY
        }
    }
    @IBInspectable open var paddingX: CGFloat = 5 {
        didSet {
            tagButton.paddingX = paddingX
            updateRightInsets()
        }
    }

    @IBInspectable open var tagBackgroundColor: UIColor = UIColor.gray {
        didSet {
            tagButton.tagBackgroundColor = tagBackgroundColor
        }
    }
    
    @IBInspectable open var highlightedBackgroundColor: UIColor? {
        didSet {
            tagButton.highlightedBackgroundColor = highlightedBackgroundColor
        }
    }
    
    @IBInspectable open var selectedBorderColor: UIColor? {
        didSet {
            tagButton.selectedBorderColor = selectedBorderColor
        }
    }
    
    @IBInspectable open var selectedBackgroundColor: UIColor? {
        didSet {
            tagButton.selectedBackgroundColor = selectedBackgroundColor
        }
    }
    
    var textFont: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            tagButton.titleLabel?.font = textFont
        }
    }
    
    var tagSelected: Bool {
        set {
            tagButton.isSelected = tagSelected
        }
        get {
            return tagButton.isSelected
        }
    }
    
    var currentTitle: String? {
        return tagButton.currentTitle
    }
    
    // MARK: remove button
    
    let removeButton = CloseButton()
    
    @IBInspectable open var enableRemoveButton: Bool = false {
        didSet {
            removeButton.isHidden = !enableRemoveButton
            updateRightInsets()
        }
    }
    
    @IBInspectable open var removeButtonIconSize: CGFloat = 12 {
        didSet {
            removeButton.iconSize = removeButtonIconSize
            updateRightInsets()
        }
    }
    
    @IBInspectable open var removeIconLineWidth: CGFloat = 3 {
        didSet {
            removeButton.lineWidth = removeIconLineWidth
        }
    }
    
    @IBInspectable open var removeIconLineColor: UIColor = UIColor.white.withAlphaComponent(0.54) {
        didSet {
            removeButton.lineColor = removeIconLineColor
        }
    }
    
    @IBInspectable open var removeIconImage: UIImage? {
        didSet {
            removeButton.iconImage = removeIconImage
            updateRightInsets()
        }
    }
    
    /// Handles Tap (TouchUpInside)
    open var onTap: ((TagView) -> Void)?
    open var onLongPress: ((TagView) -> Void)?
    
    // MARK: - init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    public init(title: String) {
        super.init(frame: CGRect.zero)
        tagButton.setTitle(title, for: .normal)
        
        setupView()
    }
    
    private func setupView() {
        frame.size = intrinsicContentSize
        addSubview(tagButton)
        addSubview(removeButton)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        self.addGestureRecognizer(longPress)
    }
    
    func longPress() {
        onLongPress?(self)
    }
    
    // MARK: - layout
    override open var intrinsicContentSize: CGSize {
        var size = tagButton.titleLabel?.text?.size(attributes: [NSFontAttributeName: textFont]) ?? CGSize.zero
        size.height = textFont.pointSize + paddingY * 2
        size.width += paddingX * 2
        if enableRemoveButton {
            size.width += removeButtonIconSize + paddingX
        }
        return size
    }
    
    private func updateRightInsets() {
        if enableRemoveButton && removeIconImage == nil {
            tagButton.titleEdgeInsets.right = paddingX  + removeButtonIconSize + paddingX
        }
        else {
            tagButton.titleEdgeInsets.right = paddingX
        }
    }

    open override func layoutSubviews() {
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
