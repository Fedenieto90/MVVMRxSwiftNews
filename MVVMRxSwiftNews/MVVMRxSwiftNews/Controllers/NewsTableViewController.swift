//
//  NewsTableViewController.swift
//  MVVMRxSwiftNews
//
//  Created by Federico Nieto on 31/05/2019.
//  Copyright © 2019 Federico Nieto. All rights reserved.
//

import UIKit
import RxSwift

class NewsTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    private var articlesListVM : ArticleListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        populateNews()
    }
    
    func populateNews() {
        URLRequest.load(resource: ArticlesReponse.all)
            .subscribe(onNext: { articlesResponse in
                let articles = articlesResponse.articles
                self.articlesListVM = ArticleListViewModel.init(articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articlesListVM == nil ? 0 : self.articlesListVM.articlesVM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        let articleVM = self.articlesListVM.articleAt(index: indexPath.row)
        
        articleVM.title.asDriver(onErrorJustReturn: "")
        .drive(cell.titleLabel.rx.text)
        .disposed(by: disposeBag)
        
        articleVM.desc.asDriver(onErrorJustReturn: "")
        .drive(cell.descriptionLabel.rx.text)
        .disposed(by: disposeBag)
        
        return cell
    }
}
