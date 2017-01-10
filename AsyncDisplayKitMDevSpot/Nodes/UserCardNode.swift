//
//  UserCard.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import AsyncDisplayKit

class UserCardNode: ASDisplayNode {
    let buttonNode = ASButtonNode()
    let imageNode = ASImageNode()
    fileprivate var reversed = false
    
    override init() {
        super.init()
        imageNode.image = UIImage(named: "sunflower")
        
        self.addSubnode(imageNode)
        
        self.buttonNode.addTarget(self, action: #selector(buttonTapped(_:)), forControlEvents: .touchUpInside)
        self.buttonNode.setTitle(
            "Animate",
            with: UIFont.systemFont(ofSize: 15),
            with: .blue,
            for: [.init(rawValue: 0)]
        )
        self.buttonNode.style.alignSelf = .center
        self.buttonNode.backgroundColor = .gray
        
        self.addSubnode(buttonNode)
        
        self.backgroundColor = .clear
        self.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    @objc func buttonTapped(_ sender: AnyObject) {
        reversed = !reversed
        
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: {
            
        })
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.imageNode.style.maxSize = CGSize(width: 200, height: 300)
        self.buttonNode.style.minSize = CGSize(width: 200, height: 44)
        //self.imageNode.style.preferredSize = CGSize(width: self.bounds.width, height: 200)
        //self.buttonNode.style.preferredSize = CGSize(width: self.bounds.width, height: 44)
        var children = [self.imageNode,self.buttonNode]
        
        if reversed {
            children.reverse()
        }
        
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0,
            justifyContent: .center,
            alignItems: .stretch,
            children: children
        )
    }
    
    override func animateLayoutTransition(_ context: ASContextTransitioning) {
        let initialFrame = context.initialFrame(for: self.buttonNode)
        let buttonFinalFrame = context.finalFrame(for: self.buttonNode)
        UIView.animate(
            withDuration: 3,
            delay: 0, usingSpringWithDamping: 5,
            initialSpringVelocity: 5,
            options: .curveEaseInOut,
            animations: {
                self.imageNode.frame = initialFrame
                self.buttonNode.frame = buttonFinalFrame
        }, completion: { finished in
            context.completeTransition(finished)
        })
    }
}
