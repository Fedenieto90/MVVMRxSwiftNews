//
//  ArticleViewModel.swift
//  MVVMRxSwiftNews
//
//  Created by Federico Nieto on 31/05/2019.
//  Copyright © 2019 Federico Nieto. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ArticleListViewModel {
    let articlesVM: [ArticleViewModel]
}

extension ArticleListViewModel {
    init(_ articles: [Article]) {
        self.articlesVM = articles.compactMap(ArticleViewModel.init)
    }
    
    func articleAt(index: Int) -> ArticleViewModel {
        return self.articlesVM[index]
    }
}

struct ArticleViewModel {
    let article: Article
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    
    var title: Observable<String> {
        return Observable.just(article.title)
    }
    
    var desc: Observable<String> {
        return Observable.just(article.description ?? "")
    }
    
}
