//
//  MovieDetailViewController.swift
//  Movie Database
//
//  Created by Siba Krushna Biswal on 26/07/24.
//

import UIKit

enum RatingSource: String {
    case imdb = "IMDB"
    case rottenTomatoes = "RottenTomatoes"
    case metacritic = "Metacritic"
}
class MovieDetailViewController: UIViewController {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var castReleaseDateLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var ratingValueLabel: UILabel!
    let viewModel = MovieDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setData()
        handlesegmentedControl()
    }
    private func setUI() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        castReleaseDateLabel.font = UIFont.systemFont(ofSize: 14)
        plotLabel.font = UIFont.systemFont(ofSize: 12)
        genreLabel.font = UIFont.systemFont(ofSize: 14)
        ratingValueLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
    private func setData() {
        if let url = URL(string: viewModel.movie?.poster ?? "") {
            posterImageView.loadImage(from: url)
        }
        titleLabel.text = viewModel.movie?.title
        if let actors = viewModel.movie?.actors, let year = viewModel.movie?.year {
            castReleaseDateLabel.text = "\(actors)/\(year)"
        }
        plotLabel.text = viewModel.movie?.plot
        if let genre = viewModel.movie?.genre {
            genreLabel.text = "Genres: \(genre)"
        }
        guard let ratings = viewModel.movie?.ratings else { return }
        let values = ratings.map { $0.value }
        if let value = values.first, values.count != 1 {
            ratingValueLabel.text = "Rating: \(value)"
        } else if let value = values.first {
            ratingValueLabel.text = "\(viewModel.movie?.ratings.first?.source ?? "") Rating: \(value)"
            ratingValueLabel.textAlignment = .left
            segmentedControl.superview?.isHidden = true
        }
    }
    private func handlesegmentedControl() {
        guard let ratings = viewModel.movie?.ratings else { return }
        let sources = ratings.map { $0.source }
        segmentedControl.removeAllSegments()
        for (index, source) in sources.enumerated() {
            if source == "Internet Movie Database" {
                segmentedControl.insertSegment(withTitle: "IMDB", at: index, animated: false)
            } else if source == "Rotten Tomatoes" {
                segmentedControl.insertSegment(withTitle: "RottenTomatoes", at: index, animated: false)
            } else if source == "Metacritic" {
                segmentedControl.insertSegment(withTitle: "Metacritic", at: index, animated: false)
            }
        }
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        guard let ratings = viewModel.movie?.ratings else { return }
        let values = ratings.map { $0.value }
        ratingValueLabel.text = "Rating: \(values[sender.selectedSegmentIndex])"
    }
    
}
