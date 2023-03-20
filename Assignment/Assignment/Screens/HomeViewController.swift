//
//  HomeViewController.swift
//  Assignment
//
//  Created by Mohammad Zaid on 20/03/23.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    private let viewModel = TrendingPostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trending Topics"
        tableView.register(PostTableViewCell.nib, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier())
        bind()
    }
    
    func bind() {
        viewModel.getTrendingPost()
        viewModel.post.subcribe { response in
            guard let data = response else {
                return
            }
            self.tableView.reloadData()
        }
    }

}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.trendingPost?.meta.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier()) as! PostTableViewCell
        let post = viewModel.trendingPost?.meta[indexPath.row]
        cell.delegate = self
        cell.configure(tagText: post?.tagText ?? "", post: viewModel.trendingPost)
        return cell
    }
    
    
}

extension HomeViewController: GrowingCellProtocol {
    func updateHeightOfRow(_ cell: UITableViewCell) {
        if let _ = tableView.indexPath(for: cell) {
            // Disabling animations gives us our desired behaviour
            UIView.setAnimationsEnabled(false)
            /* These will causes table cell heights to be recaluclated,
             without reloading the entire cell */
            tableView.beginUpdates()
            tableView.endUpdates()
            // Re-enable animations
            UIView.setAnimationsEnabled(true)
        }
    }
}
