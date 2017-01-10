//
//  PagerPhotoCellNode.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import AsyncDisplayKit
import UIKit

class PagerPhotoCellNode: ASCellNode {
    let userViewModel: UserViewModelProtocol
    let photoNode: ASNetworkImageNode = ASNetworkImageNode()
    let nickNode: ASTextNode = ASTextNode()
    let pageNode: ASTextNode = ASTextNode()
    
    init(userViewModel: UserViewModelProtocol) {
        self.userViewModel = userViewModel
        
        super.init()
        
        photoNode.setURL(userViewModel.photoUrl(quality: .Full), resetToDefault: false)
        self.addSubnode(photoNode)
        
        nickNode.attributedText = NSAttributedString(
            string: userViewModel.fullName,
            attributes: [
                NSForegroundColorAttributeName: UIColor.white,
                NSFontAttributeName: UIFont.systemFont(ofSize: 30)
            ]
        )
        nickNode.backgroundColor = UIColor(white: 0, alpha: 0.2)
        self.addSubnode(nickNode)
        
        pageNode.backgroundColor = UIColor(white: 0, alpha: 0.2)
        self.addSubnode(pageNode)
    }
    
    override func didEnterPreloadState() {
        
        if let index = self.indexPath?.row {
            pageNode.attributedText = NSAttributedString(
                string: String(index + 1),
                attributes: [
                    NSForegroundColorAttributeName: UIColor.white,
                    NSFontAttributeName: UIFont.systemFont(ofSize: 30)
                ])
        }
        
        super.didEnterPreloadState()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let relative = ASRelativeLayoutSpec(horizontalPosition: .start, verticalPosition: .end, sizingOption: .init(rawValue: 0), child: self.nickNode)
        let insets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0,left: 10,bottom: 60,right: 0), child: relative)
        
       
        
        let background = ASBackgroundLayoutSpec(
            child: insets,
            background: self.photoNode
        )
        
        background.style.layoutPosition = CGPoint()
        background.style.minSize = constrainedSize.max
        
        let centered = ASCenterLayoutSpec(
            centeringOptions: .X,
            sizingOptions: .init(rawValue: 0),
            child: self.pageNode
        )
        centered.style.layoutPosition.y = 20
        
        return  ASAbsoluteLayoutSpec(sizing: .default, children: [
            background,
            centered
            ])
    }
}
