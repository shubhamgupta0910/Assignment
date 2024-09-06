//
//  PostsViewModel.swift
//  PostsAssignment
//
//  Created by Shubham Gupta on 03/09/24.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class PostsViewModel {
    
    let disposeBag = DisposeBag()
    let postsRelay = BehaviorRelay<[PostModel]>(value: [])
    
    init() {
    }
    
    func loadPostsFromRealm() {
        let realm = try! Realm()
        let posts = realm.objects(PostModel.self)
        if posts.isEmpty {
            fetchPosts()
        } else {
            postsRelay.accept(Array(posts))
        }
    }
    
    func fetchPosts() {
        NetworkService.shared.fetchPosts()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                switch result {
                case .success(let posts):
                    // Handle success - e.g., update UI with posts
                    print("Fetched posts: \(posts)")
                    self?.postsRelay.accept(posts)
                    
                    do {
                        let realm = try Realm()
                        try realm.write {
                            realm.add(posts, update: .modified)
                        }
                    } catch {
                        print("Error Realm")
                    }
                    
                case .failure(let error):
                    // Handle error
                    print("Error fetching posts: \(error.localizedDescription)")
                }
            }
            .disposed(by: disposeBag)
    }
    
    func toggleFavourite(postId: Int) {
        let realm = try! Realm()
        if let post = realm.object(ofType: PostModel.self, forPrimaryKey: postId) {
            try! realm.write {
                post.favourite.toggle()
            }
            // Reload data from Realm after toggling favourite
            loadPostsFromRealm()
        }
    }
}
