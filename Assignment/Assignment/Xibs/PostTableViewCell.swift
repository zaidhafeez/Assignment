//
//  PostTableViewCell.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import UIKit
@objc
protocol GrowingCellProtocol {
    func updateHeightOfRow(_ cell: UITableViewCell)
}

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTagText: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var post: PostList?
    
    weak var delegate: GrowingCellProtocol?
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 220, height: 320)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
    
    func configure(tagText: String, post: PostList?) {
        lblTagText.text = "#\(tagText)"
        self.post = post
        delegate?.updateHeightOfRow(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(TrendingCollectionViewCell.nib, forCellWithReuseIdentifier: TrendingCollectionViewCell.reuseIdentifier())
        collectionView.dataSource = self
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension PostTableViewCell: UICollectionViewDataSource {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.post?.posts.count ?? 0
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.reuseIdentifier(), for: indexPath) as!
    TrendingCollectionViewCell
    let post = self.post?.posts[indexPath.row] ?? []
    post.forEach { post in
        cell.configure(post: post)
    }
    return cell
}

}
