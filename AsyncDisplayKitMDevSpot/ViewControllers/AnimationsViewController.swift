//
//  AnimationsViewController.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import AsyncDisplayKit

class AnimationsViewController: ASViewController<ASDisplayNode> {
    let card = UserCardNode()
    
    convenience init() {
        self.init(node: ASDisplayNode())
        
        //self.card.frame.size = CGSize(width: 200, height: 200)
        
        self.node.addSubnode(card)
        self.node.backgroundColor = .white
        
        self.title = "Layout transitions"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.card.view.center = self.node.view.center
        self.card.frame.size = self.card.layoutThatFits(
            ASSizeRange(min: CGSize(), max: self.node.bounds.size)
        ).size
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
