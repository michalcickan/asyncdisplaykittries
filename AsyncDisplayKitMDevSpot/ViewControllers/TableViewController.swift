//
//  TableViewController.swift
//  AsyncDisplayKitMDevSpot
//
//  Created by Michal Čičkán on 08/01/2017.
//  Copyright © 2017 Michal Čičkán. All rights reserved.
//

import AsyncDisplayKit

class TableViewController: ASViewController<ASTableNode> {
    let tableNode : ASTableNode
    
    lazy var dataSource : UserDataSource = {
        let source = UserDataSource()
        
        return source
    }()
    
    init() {
        tableNode = ASTableNode(style: .plain)
        
        super.init(node: tableNode)
        
        tableNode.delegate = self
        tableNode.dataSource = self
        //tableNode.view.leadingScreensForBatching = 3
        // tabbar title
        self.title = "Table node"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "User list"
        dataSource.fetchUsers(completionHandler: { [weak self] indices in
            self?.newModelsInserted(indices: indices)
        })
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newModelsInserted(indices: [Int], insertCompletion: ((_ success: Bool)-> Void)? = nil) {
        self.tableNode.performBatchUpdates({
            self.tableNode.insertRows(at:
                indices.map{
                    IndexPath(
                        item: $0,
                        section: 0
                    )
                }
                , with: .automatic)
        }, completion: insertCompletion)
    }
}

extension TableViewController : ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.userViewModels.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        //let copy viewModel, because it indexPath can be modified
        let viewModel = dataSource.userViewModels[indexPath.row]
        
        return {
            return UserCellNode(userViewModel: viewModel)
        }
    }
}

extension TableViewController : ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        //width is not considered. It can be only width of tableview
        return ASSizeRange(
            min: CGSize(width: 0, height: 44),
            max: CGSize(width: 0, height: CGFloat.infinity)
        )
    }
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        dataSource.fetchNext() {[weak self] indices in
            self?.newModelsInserted(indices: indices, insertCompletion: { success in
                context.completeBatchFetching(true)
            })
        }
    }
}
