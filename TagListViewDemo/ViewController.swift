//
//  ViewController.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TagListViewDelegate {

    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var biggerTagListView: TagListView!
    @IBOutlet weak var biggestTagListView: TagListView!
    @IBOutlet weak var customTagListView: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagListView.delegate = self
        tagListView.addTag("TagListView")
        tagListView.addTag("TEAChart")
        tagListView.addTag("To Be Removed")
        tagListView.addTag("To Be Removed")
        tagListView.addTag("Quark Shell")
        tagListView.removeTag("To Be Removed")
        tagListView.addTag("On tap will be removed").onTap = { [weak self] tagView in
            self?.tagListView.removeTagView(tagView)
        }
        
        let tagView = tagListView.addTag("gray")
        tagView.tagBackgroundColor = UIColor.gray
        tagView.onTap = { tagView in
            print("Don’t tap me!")
        }

        tagListView.insertTag("This should be the third tag", at: 2)
        
        biggerTagListView.delegate = self
        biggerTagListView.textFont = UIFont.systemFont(ofSize: 15)
        biggerTagListView.shadowRadius = 2
        biggerTagListView.shadowOpacity = 0.4
        biggerTagListView.shadowColor = UIColor.black
        biggerTagListView.shadowOffset = CGSize(width: 1, height: 1)
        biggerTagListView.addTag("Inboard")
        biggerTagListView.addTag("Pomotodo")
        biggerTagListView.addTag("Halo Word")
        biggerTagListView.alignment = .center
        
        biggestTagListView.delegate = self
        biggestTagListView.textFont = UIFont.systemFont(ofSize: 24)
        // it is also possible to add all tags in one go
        biggestTagListView.addTags(["all", "your", "tag", "are", "belong", "to", "us"])
        biggestTagListView.alignment = .right
        
        
        customTagListView.backgroundColor = UIColor.clear
        customTagListView.delegate = self
        customTagListView.textFont = UIFont.systemFont(ofSize: 14)
        customTagListView.textColor = UIColor.gray
        customTagListView.selectedTextColor = UIColor.gray
        customTagListView.tagBackgroundColor = UIColor.darkGray
        customTagListView.marginX = 5
        customTagListView.marginY = 10
        customTagListView.paddingX = 8
        customTagListView.paddingY = 8
        customTagListView.enableRemoveButton = true
        customTagListView.removeButtonIconSize = 20
        customTagListView.removeIconImage = UIImage(named: "tag_delete")
        customTagListView.addTag("custom")
        customTagListView.addTag("tag")
        customTagListView.addTag("list")
        customTagListView.addTag("view")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: TagListViewDelegate
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.tagSelected = !tagView.tagSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}

