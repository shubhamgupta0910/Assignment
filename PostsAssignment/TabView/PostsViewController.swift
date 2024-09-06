//
//  PostsViewController.swift
//  PostsAssignment
//
//  Created by Shubham Gupta on 03/09/24.
//

import UIKit
import RxSwift

class PostsViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    
    var viewModel = PostsViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadPostsFromRealm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViewBinding()
        
        logoutButton.rx.tap.asObservable().subscribe(onNext: { [weak self] _ in
            guard let weakSelf = self else { return }
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            weakSelf.navigateToLogin()
            
        }).disposed(by: disposeBag)
    }
    
    private func setupTableViewBinding() {
        // Bind the postsRelay to the table view
        viewModel.postsRelay
            .bind(to: tableView.rx.items(cellIdentifier: "PostCell", cellType: PostCell.self)) { row, post, cell in
                cell.titleLabel?.text = post.title
                cell.descLabel?.text = post.body
                cell.accessoryType = post.favourite ? .checkmark : .none
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(PostModel.self)
            .subscribe(onNext: { [weak self] post in
                self?.viewModel.toggleFavourite(postId: post.id)
            })
            .disposed(by: disposeBag)
    }
    
    func navigateToLogin() {
        self.performSegue(withIdentifier: "logout", sender: nil)
    }
    
}
