//
//  MovieDetailViewController.swift
//  FilmBrowser
//
//  Created by Akin O. on 28.07.2021.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController, Storyboardable {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var movieTypeLabel: UILabel!
    @IBOutlet weak var moviePlotTextView: UITextView!
    
    let viewModel = MovieDetailViewModel()
    
    var movieTitle: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        if movieTitle != "" {
            viewModel.getMovie(title: movieTitle)
        }
    }
    
    func setData(data: MovieResponse){
         if let url =  URL(string: data.poster ?? String()) {
            movieImageView.kf.setImage(with: url)
        }
        movieTitleLabel.text = data.title
        movieDateLabel.text = data.released
        movieTypeLabel.text = data.type
        moviePlotTextView.text = data.plot
        Logger.LogIt(movie: data)
    }
    
}

extension MovieDetailViewController: MovieDetailVMDelegate{
    func fetched(response: MovieResponse) {
        setData(data: response)
    }
}
