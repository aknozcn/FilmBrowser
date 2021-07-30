//
//  MoviesTableViewCell.swift
//  FilmBrowser
//
//  Created by Akin O. on 27.07.2021.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var tableViewCellCard: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        tableViewCellCard.addShadow()
    }

    var cellItem: MovieItem! {
        didSet{
            if let url = URL(string: "\(cellItem.poster ?? "")") {
                movieImageView.kf.setImage(with: url)
            }
            movieTitleLabel.text = cellItem.title
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
