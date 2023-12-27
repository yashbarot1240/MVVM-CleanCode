//
//  NyArticlesListRouter.swift
//  MVVMDemo
//
//  Created by Yash Barot on 27/12/23.
//

import Foundation

enum NyArticlesListScreens {
    case details
    
}

protocol NyArticlesListRouter {
    func perform(_ screen: NyArticlesListScreens, from source: NyTimesMostPopularArticlesList, withData data:ArticlesListCellViewModel)
}

class DefaultNyArticlesListRouter: NyArticlesListRouter {
    
    func perform(_ screen: NyArticlesListScreens, from source: NyTimesMostPopularArticlesList, withData data:ArticlesListCellViewModel) {
        switch screen {
        case .details:
            break
        }
    }
}

// MARK: Helpers

private extension DefaultNyArticlesListRouter {
    
  
  
}
