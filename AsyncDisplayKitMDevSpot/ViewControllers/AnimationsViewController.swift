//
//  AnimationsViewController.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import AsyncDisplayKit

class AnimationsViewController: ASViewController<ASDisplayNode> {
    convenience init() {
        self.init(node: ASDisplayNode())
        self.node.backgroundColor = .red
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
