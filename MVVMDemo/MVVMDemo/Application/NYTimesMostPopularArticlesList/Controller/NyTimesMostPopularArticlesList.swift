//
//  NYTimesMostPopularArticlesList.swift
//  MVVMDemo
//
//  Created by Yash Barot on 27/12/23.
//

import UIKit
import DropDown

class NyTimesMostPopularArticlesList: UIViewController {

    @IBOutlet weak var tableViewList: UITableView!
    
    @IBOutlet weak var labelFilter: UILabel!
    
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
        
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    
    @IBAction func button_dropDownClick(_ sender: UIButton) {
        self.openDropDown(sender: sender)
    }
    
}

extension NyTimesMostPopularArticlesList {
    
    //Mark: Setup View Component
    func initView() {
        self.tableViewList.delegate = self
        self.tableViewList.dataSource = self
        self.tableViewList.register(UINib(nibName: "NyTimesMostPopularArticlesTableViewCell", bundle: nil), forCellReuseIdentifier: Cells.articalListCellIdentifier)
        
        
        self.navigationItem.title = "Articles"

        

    }
    
    //Mark: Update View
    func updateUI()  {
        self.labelFilter.text = "Today"
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
                self?.hideLoader()
            }
        }
        
        self.loadArticles(period: "1")
        
    }
    
    func loadArticles(period : String ){
        
        viewModel.getArticlesList(period: period)
        self.startLoader(message: "Load articles...")
        
    }
    
    
    func openDropDown(sender : UIButton){
        let dropDown = DropDown()

        // The view to which the drop down will appear on
        dropDown.anchorView = sender // UIView or UIBarButtonItem
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["Today", "Last 7 Days", "Last 30 Days"]
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            DispatchQueue.main.async {
                self.labelFilter.text = item
                
                if index == 0 {
                    self.loadArticles(period: "1")
                }else if index == 1 {
                    self.loadArticles(period: "7")
                }else if index == 2 {
                    self.loadArticles(period: "30")
                }
            }
            
            
        }

        dropDown.show()

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

