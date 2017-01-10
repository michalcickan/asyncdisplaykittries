//
//  UserCellNode.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import AsyncDisplayKit

class UserCellNode: ASCellNode {
    let avatarNode : ASNetworkImageNode
    let nameNode : ASTextNode
    let descriptionNode: ASTextNode
    let textNode: ASTextNode
    let fullscreenPhotoNode : ASNetworkImageNode
    
    fileprivate let userViewModel : UserViewModelProtocol
    
    init(userViewModel: UserViewModelProtocol) {
        self.userViewModel = userViewModel
        
        avatarNode = ASNetworkImageNode()
        nameNode = ASTextNode()
        textNode = ASTextNode()
        descriptionNode = ASTextNode()
        fullscreenPhotoNode = ASNetworkImageNode()
        
        super.init()
        
        self.automaticallyManagesSubnodes = true
        
        configureAvatarNode()
        //self.addSubnode(avatarNode)
        
        nameNode.maximumNumberOfLines = 1
        nameNode.attributedText = NSAttributedString(
            string: userViewModel.fullName,
            attributes:[
                NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17)
            ]
        )
        self.addSubnode(nameNode)
        
        descriptionNode.attributedText = NSAttributedString(
            string: userViewModel.description,
            attributes: [
                NSForegroundColorAttributeName: UIColor.gray,
                
                ]
        )
        descriptionNode.maximumNumberOfLines = 1
        //if cannot be displayed, shrink it
        descriptionNode.style.flexShrink = 1
        //self.addSubnode(descriptionNode)
        
        textNode.attributedText = NSAttributedString(string: userViewModel.aboutText)
        //self.addSubnode(textNode)
        
        fullscreenPhotoNode.placeholderColor = .gray
        fullscreenPhotoNode.url = userViewModel.photoUrl(quality: .Full)
        fullscreenPhotoNode.placeholderFadeDuration = 2
        fullscreenPhotoNode.contentMode = .scaleAspectFill
        fullscreenPhotoNode.style.preferredSize = self.bounds.size
        
    }
    
    // MARK: - Node configurations
    func configureAvatarNode() {
        //avatar node data
        avatarNode.placeholderColor = .gray
        avatarNode.setURL(
            userViewModel.photoUrl(quality: .Thumbnail),
            resetToDefault: false
        )
        let radius : CGFloat = 30
        avatarNode.style.width = ASDimensionMake(radius*2)
        avatarNode.style.height = ASDimensionMake(radius*2)
        avatarNode.cornerRadius = radius
        //clip to bounds cost performance, so we handle it in modification block
        avatarNode.imageModificationBlock = { image in
            var modifiedImage = UIImage()
            let cornerRadius = image.size.width / 2
            let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
            
            UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
            UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
            image.draw(in: rect)
            
            modifiedImage = UIGraphicsGetImageFromCurrentImageContext()!
            
            UIGraphicsEndImageContext();
            
            return modifiedImage;
        }
        
        avatarNode.shouldRasterizeDescendants = true
    }
    
    // MARK: - Layout computing
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // make fullscreen image ratio to 1:2
        //layout will take care of that
        //self.fullscreenPhotoNode.style.width = ASDimensionMake("100%")
        let aspectLayout = ASRatioLayoutSpec(ratio: 1/2, child: self.fullscreenPhotoNode)
        let fullscreenInsetLayout = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 10,left: 5,bottom: 0,right: 5),
            child: aspectLayout
        )
        
        //info layout
        var infoSpecElems = [nameNode]
        if !userViewModel.description.isEmpty {
            infoSpecElems.append(descriptionNode)
        }
        let horizontalInfoLayout = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 5,
            justifyContent: .start,
            alignItems: .start,
            children: infoSpecElems
        )
        
        let contentLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 5,
            justifyContent: .end,
            alignItems: .start,
            children: [horizontalInfoLayout, self.textNode, fullscreenInsetLayout]
        )
        //in order to not let text node grow behind bounds, we need to set flex shrink, otherwise it won't calculate height and will continue behind right edge
        contentLayout.style.flexShrink = 1
        
        //we want to stretch it to whole cell
        let avatarContentLayout = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 10,
            justifyContent: .end,
            alignItems: .start,
            children: [avatarNode, contentLayout]
        )
        
        //insets from cell bounds
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5),
            child: avatarContentLayout
        )
    }
    
    override func didEnterPreloadState() {
        super.didEnterPreloadState()
        print("Row preloading \(self.indexPath?.row)")
    }
}
