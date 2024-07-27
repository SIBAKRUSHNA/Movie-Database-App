//
//  MovieTableViewCell.swift
//  Movie Database
//
//  Created by Siba Krushna Biswal on 26/07/24.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lanuageLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setUI()
    }
    private func setUI() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        lanuageLabel.font = UIFont.systemFont(ofSize: 14)
        yearLabel.font = UIFont.systemFont(ofSize: 14)
    }
    func setData(_ movie: Movie) {
        if let url = URL(string: movie.poster ?? "") {
            movieImageView.loadImage(from: url)
        }
        nameLabel.text = movie.title
        lanuageLabel.text = "Lanuage: \(movie.language)"
        yearLabel.text = "Year: \(movie.year)"
    }
}
