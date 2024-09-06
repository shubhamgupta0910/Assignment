//
//  NetworkService.swift
//  PostsAssignment
//
//  Created by Shubham Gupta on 04/09/24.
//

import Foundation
import Alamofire
import RxSwift

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchPosts() -> Single<[PostModel]> {
        return Single<[PostModel]>.create { single in
            let url = "https://jsonplaceholder.typicode.com/posts"
            
            // Make the API call using Alamofire
            AF.request(url, method: .get)
                .validate()
                .responseDecodable(of: [PostModel].self) { response in
                    switch response.result {
                    case .success(let posts):
                        single(.success(posts))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create()
        }
    }
}
