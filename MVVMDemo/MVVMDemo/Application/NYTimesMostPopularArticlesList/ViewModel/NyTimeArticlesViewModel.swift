//
//  NyTimeArticlesViewModel.swift
//  MVVMDemo
//
//  Created by Yash Barot on 27/12/23.
//

import Foundation

class NyTimeArticlesViewModel {
    
    let apiService: APIServiceProtocol
    
    private var articles: [ArticlesResult] = []
    
    private var cellViewModels: [ArticlesListCellViewModel] = [ArticlesListCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    var reloadTableViewClosure: (()->())?
    
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func getArticlesList(period : String) {
        self.isLoading = true
        apiService.getArticlesList(period: period) { [weak self] success, articles, error in
            
            self?.isLoading = false
            
            if let error = error {
             
                self?.alertMessage = error.localizedDescription
            } else {

                self?.processValidate(articles: articles!)
                
            }
            
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> ArticlesListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    
    func createCellViewModel(title: String, author: String, date: String, small_image: String, large_image: String) -> ArticlesListCellViewModel {
        
        return ArticlesListCellViewModel(title: title, author: author, date: date, small_image: small_image, large_image: large_image)
    }
    
    private func processValidate(articles: MostPopularArticles) {
        self.articles = articles.results?.compactMap { $0 } ?? []
        var vms = [ArticlesListCellViewModel]()
        for article in self.articles {
            let small_pic = article.media?.first?.mediaMetadata?.first?.url ?? ""
            let large_pic = article.media?.first?.mediaMetadata?.last?.url ?? ""
            vms.append( createCellViewModel(title: article.title ?? "", author: article.byline  ?? "", date: article.publishedDate  ?? "", small_image: small_pic, large_image: large_pic))
        }
        self.cellViewModels = vms
    }
}

struct ArticlesListCellViewModel {
    let title: String
    let author: String
    let date: String
    let small_image: String
    let large_image: String
}
