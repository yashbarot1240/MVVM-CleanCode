//
//  NYTimesMostPopularArticlesTableViewCell.swift
//  MVVMDemo
//
//  Created by Yash Barot on 27/12/23.
//

import UIKit
import SDWebImage

class NyTimesMostPopularArticlesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var imageViewMedia: UIImageView!{
        didSet{
            imageViewMedia.backgroundColor = .lightGray
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageViewMedia.cornerRadius = 25
    }
    
    
    func setUpData(data : ArticlesListCellViewModel){
        self.labelTitle.text = data.title
        self.labelAuthor.text = data.author
        self.labelDate.text = data.date
        
        self.imageViewMedia.sd_setImage(with: URL(string: data.small_image), placeholderImage: UIImage(named: "ic_placeholder"))
    }
}
