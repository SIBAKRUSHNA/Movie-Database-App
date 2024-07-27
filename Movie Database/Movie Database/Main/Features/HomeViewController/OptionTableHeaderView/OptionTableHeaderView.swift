//
//  OptionTableHeaderView.swift
//  Movie Database
//
//  Created by Siba Krushna Biswal on 26/07/24.
//

import UIKit

class OptionTableHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var upAndDownImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        headerTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
    }
    func setData(_ headerTitle: String) {
        headerTitleLabel.text = headerTitle
    }
    func setButtonTag(_ section: Int) {
        expandButton.tag = section
    }
}
