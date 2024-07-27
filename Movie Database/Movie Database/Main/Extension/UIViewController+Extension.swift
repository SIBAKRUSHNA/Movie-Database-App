//
//  UIViewController+Extension.swift
//  Movie Database
//
//  Created by Siba Krushna Biswal on 26/07/24.
//

import UIKit

extension UIViewController {
    func gotoDetailViewController(_ searchText: String) {
        guard let detailViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailViewController.viewModel.searchText = searchText
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    func gotoMovieDetailViewController(_ selectedMovie: Movie) {
        guard let movieDetailViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else { return }
        movieDetailViewController.viewModel.movie = selectedMovie
        self.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
