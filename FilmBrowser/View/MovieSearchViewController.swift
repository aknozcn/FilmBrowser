//
//  ViewController.swift
//  FilmBrowser
//
//  Created by Akin O. on 27.07.2021.
//

import UIKit
import Firebase
import Kingfisher
import JGProgressHUD

class MovieSearchViewController: UIViewController, Storyboardable {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noDataLabel: UILabel!


    private let hud = JGProgressHUD()
    let viewModel = MovieSearchViewModel()
    var searchedMovies: MovieSearchResponse? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        searchBar.delegate = self

        viewModel.delegate = self

        if searchedMovies?.search == nil {
            tableView.isHidden = true
            noDataLabel.isHidden = false
        }
    }
}

extension MovieSearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let title = searchedMovies?.search?[indexPath.row].title {
            let viewController = MovieDetailViewController.instantiate()
            viewController.movieTitle = title
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedMovies?.search?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MoviesTableViewCell else { return UITableViewCell() }
        if let element = searchedMovies?.search?[indexPath.row] {
            cell.cellItem = element
        }
        
        return cell
    }
}

extension MovieSearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.viewModel.searchMovies(title: searchText)
                self.hud.dismiss()
            }
        }

        tableView.isHidden = false
        noDataLabel.isHidden = true
        if searchText.count < 1 {
            tableView.isHidden = true
            noDataLabel.isHidden = false
            tableView.reloadData()
            noDataLabel.text = "Loodos"
        }
    }

    func searchBarTextDidBeginEditing(_searchBar: UISearchBar) {

        searchBar.setShowsCancelButton(true, animated: true)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

        searchBar.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        searchBar.endEditing(true)
    }

    func searchBarCancelButtonClicked(_searchBar: UISearchBar) {

        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        tableView.reloadData()
        searchBar.endEditing(true)

    }
}

extension MovieSearchViewController: MovieSearchVMDelegate {
    func fetched(response: MovieSearchResponse) {
        searchedMovies = response
        tableView.reloadData()
        
        if searchedMovies?.search?.count == nil {
            tableView.isHidden = true
            noDataLabel.isHidden = false
            noDataLabel.text = "No Data"
        }
    }
}

