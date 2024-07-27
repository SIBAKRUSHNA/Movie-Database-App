//
//  UIImageView+Extension.swift
//  Movie Database
//
//  Created by Siba Krushna Biswal on 26/07/24.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
