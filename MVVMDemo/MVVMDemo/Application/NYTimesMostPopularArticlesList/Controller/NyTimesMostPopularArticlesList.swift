//
//  NYTimesMostPopularArticlesList.swift
//  MVVMDemo
//
//  Created by Yash Barot on 27/12/23.
//

import UIKit


class NyTimesMostPopularArticlesList: UIViewController {

    @IBOutlet weak var tableViewList: UITableView!
    
    lazy var viewModel: NyTimeArticlesViewModel = {
        return NyTimeArticlesViewModel()
    }()
    
    var router: NyArticlesListRouter = {
        return DefaultNyArticlesListRouter()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Init the static view
        initView()
        
        // init view model
        initVM()
    }


}

extension NyTimesMostPopularArticlesList {
    
    //Mark: Setup View Component
    func initView() {
        self.tableViewList.delegate = self
        self.tableViewList.dataSource = self
        self.tableViewList.register(UINib(nibName: "NyTimesMostPopularArticlesTableViewCell", bundle: nil), forCellReuseIdentifier: Cells.articalListCellIdentifier)

        

    }
    
    //Mark: Update View
    func updateUI()  {
       
    }
        
    //Mark: Setup ViewModel
    func initVM() {
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
    
        viewModel.updateLoadingStatus = { [weak self] () in
         
        }
  
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableViewList.reloadData()
            }
        }
        
        viewModel.getArticlesList(period: "7")
        
    }
    
}



extension NyTimesMostPopularArticlesList: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.articalListCellIdentifier , for: indexPath) as? NyTimesMostPopularArticlesTableViewCell else {
            fatalError("Cell not register")
        }
        
        cell.setUpData(data: viewModel.getCellViewModel( at: indexPath ))
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.router.perform(.details, from: self, withData: viewModel.getCellViewModel( at: indexPath ))
    }
    
}

