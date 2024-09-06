//
//  FavouriteViewModel.swift
//  PostsAssignment
//
//  Created by Shubham Gupta on 05/09/24.
//

import RxSwift
import RxCocoa
import RealmSwift

class FavouriteViewModel {
    
    let favouritePostsRelay = BehaviorRelay<[PostModel]>(value: [])
    
    // Method to load only favourite posts from Realm
    func loadFavouritePostsFromRealm() {
        let realm = try! Realm()
        let favouritePosts = realm.objects(PostModel.self).filter("favourite == true")
        
        // Convert Realm Results to Array and update the relay
        favouritePostsRelay.accept(Array(favouritePosts))
    }
    
    func toggleFavourite(postId: Int) {
        let realm = try! Realm()
        if let post = realm.object(ofType: PostModel.self, forPrimaryKey: postId) {
            try! realm.write {
                post.favourite.toggle()
            }
            // Reload favourites after toggling favourite status
            loadFavouritePostsFromRealm()
        }
    }
}
