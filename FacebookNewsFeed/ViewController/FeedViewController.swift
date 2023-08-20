//
//  ViewController.swift
//  FacebookNewsFeed
//
//  Created by Ting on 2023/8/9.
//

import UIKit

let cellId = "cellId"

class FeedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        navigationItem.title = "Facebook Feed"
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        collectionView.alwaysBounceVertical = true
    }
    
    private func setupUI() {
        
        let postTing = Post()
        
        postTing.name = "Ting"
        postTing.statusText = "跌的越大一跤，我越是有站起來往前衝的動力。"
        postTing.statusImageName = "skipAndLoafer2"
        postTing.profileImageName = "Skip and Loafer"
        postTing.numLikes = 389
        postTing.numComments = 298
        postTing.statusImageUrl = "https://imageproxy.icook.network/resize?height=1786.2838915470495&width=1400&nocrop=false&url=https%3A%2F%2Fuploads-blog.icook.network%2F2023%2F06%2Fa5b20a8b-fygt7sfauaqxfqr-627x800.jpg&type=auto"
        
        let postSue = Post()
        postSue.name = "Sue Yu"
        postSue.statusText = "They say that the best blaze burns brightest, when circumstances are at their worst."
        postSue.statusImageName = "withHowl"
        postSue.profileImageName = "卡西法"
        postSue.numLikes = 864
        postSue.numComments = 253
        
        let postCat = Post()
        postCat.name = "能幹貓"
        postCat.statusText = "主人不去工作=>賺不到錢=>沒有罐罐=>餓死，所以要成為超級能幹的貓。"
        postCat.statusImageName = "catClean"
        postCat.profileImageName = "能幹貓"
        postCat.numLikes = 1864
        postCat.numComments = 975
        
        posts.append(postTing)
        posts.append(postCat)
        posts.append(postSue)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
        feedCell.post = posts[indexPath.item]
        
        return feedCell
    }

    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let statusText = posts[indexPath.item].statusText {
            let rect = NSString(string: statusText).boundingRect(
                with: CGSize(width: view.frame.width, height: 1000),
                options: [.usesFontLeading, .usesLineFragmentOrigin],
                attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)],
                context: nil)
        
            let knownHeight: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44

            return CGSize(width: view.frame.width, height: rect.height + knownHeight + 24)
        }
        
        return CGSize(width: view.frame.width, height: 500)
    }
}
