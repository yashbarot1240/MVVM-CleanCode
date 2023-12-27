//
//  NYTimesMostPopularArticlesDetails.swift
//  Avrioc Technologies
//
//  Created by Yash Barot on 27/12/23.
//

import UIKit


class NYTimesMostPopularArticlesDetails: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var imageViewMedia: UIImageView!{
        didSet{
            imageViewMedia.backgroundColor = .lightGray
            imageViewMedia.contentMode = .scaleAspectFill
        }
    }
    
    var data : ArticlesListCellViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Init the static view
        initView()
        
        // init view model
        initVM()
        
        //update view with data model
        updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageViewMedia.cornerRadius = 5
    }


}

extension NYTimesMostPopularArticlesDetails {
    
    //Mark: Setup View Component
    func initView() {
        

        

    }
    
    //Mark: Update View
    func updateUI()  {
        self.labelTitle.text = data?.title ?? ""
        self.labelAuthor.text = data?.author ?? ""
        self.labelDate.text = data?.date ?? ""
        
        self.imageViewMedia.sd_setImage(with: URL(string: data?.large_image ?? ""), placeholderImage: UIImage(named: "ic_placeholder"))
    }
        
    //Mark: Setup ViewModel
    func initVM() {
        
        
    }
    
}





