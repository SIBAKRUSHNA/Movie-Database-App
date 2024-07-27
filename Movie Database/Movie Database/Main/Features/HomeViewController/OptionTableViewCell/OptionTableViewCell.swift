//
//  OptionTableViewCell.swift
//  Movie Database
//
//  Created by Siba Krushna Biswal on 26/07/24.
//

import UIKit

class OptionTableViewCell: UITableViewCell {
    @IBOutlet weak var optionTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    func setData(_ optionText: String) {
        optionTextLabel.text = optionText
    }
}
