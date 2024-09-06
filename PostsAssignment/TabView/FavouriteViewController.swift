//
//  FavouriteViewController.swift
//  PostsAssignment
//
//  Created by Shubham Gupta on 05/09/24.
//
import UIKit
import RxSwift

class FavouriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = FavouriteViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViewBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadFavouritePostsFromRealm()
    }
    
    private func setupTableViewBinding() {
        tableView.rx.setDelegate(self)
                    .disposed(by: disposeBag)
        
        // Bind the postsRelay to the table view
        viewModel.favouritePostsRelay
            .bind(to: tableView.rx.items(cellIdentifier: "PostCell", cellType: PostCell.self)) { row, post, cell in
                cell.titleLabel?.text = post.title
                cell.descLabel?.text = post.body
            }
            .disposed(by: disposeBag)
    }
    
}

extension FavouriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Unfavourite") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            
            // Get the post that needs to be removed from favourites
            let post = self.viewModel.favouritePostsRelay.value[indexPath.row]
            
            // Toggle the favourite status
            self.viewModel.toggleFavourite(postId: post.id)
            
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: "star.slash")
        
        // Create the swipe actions configuration
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
