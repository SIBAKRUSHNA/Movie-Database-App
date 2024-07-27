//
//  DetailViewController.swift
//  Movie Database
//
//  Created by Siba Krushna Biswal on 26/07/24.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var movieTableView: UITableView!
    var viewModel = DetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadMovies()
        movieTableView.reloadData()
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        backButton.tintColor = .gray
        title = "Detail"
    }
}
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filterMovies().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell()}
        cell.setData(viewModel.filterMovies()[indexPath.row])
        return cell
    }
}
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoMovieDetailViewController(viewModel.filterMovies()[indexPath.row])
    }
}
