//
//  PagerViewController.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import AsyncDisplayKit

class PagerViewController: ASViewController<ASPagerNode> {
    lazy var dataSource : UserDataSource = {
       return UserDataSource()
    }()
    
    let pagerNode : ASPagerNode
    
    init() {
        pagerNode = ASPagerNode()
        super.init(node: pagerNode)
    
        pagerNode.setDataSource(self)
        self.title = "Pager node"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.fetchUsers(completionHandler: { indices in
            self.pagerNode.reloadData()
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PagerViewController : ASPagerDataSource {
    func numberOfPages(in pagerNode: ASPagerNode) -> Int {
        return dataSource.userViewModels.count
    }
    
    func pagerNode(_ pagerNode: ASPagerNode, nodeBlockAt index: Int) -> ASCellNodeBlock {
        let userVM = dataSource.userViewModels[index]
        return {
            return PagerPhotoCellNode(userViewModel: userVM)
        }
    }
}

extension PagerViewController : ASPagerDelegate {
    func shouldBatchFetch(for collectionNode: ASCollectionNode) -> Bool {
        return false
    }
}
