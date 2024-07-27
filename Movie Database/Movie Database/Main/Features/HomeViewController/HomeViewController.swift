//
//  HomeViewController.swift
//  Movie Database
//
//  Created by Siba Krushna Biswal on 26/07/24.
//

import UIKit


class HomeViewController: UIViewController {
    @IBOutlet weak var optionTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    private var viewModel = HomeViewModel()
    private var selectedSection: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        viewModel.loadMovies()
        addToolBar()
    }
    private func setUI() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backButton.tintColor = .gray
        navigationItem.backBarButtonItem = backButton
        title = "Movie Database"
        searchTextField.delegate = self
        searchTextField.superview?.layer.cornerRadius = (searchTextField.superview?.frame.height ?? 0) / 2
        optionTableView.register(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionTableViewCell")
        optionTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }
    private func addToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexSpace, doneButton]
        searchTextField.inputAccessoryView = toolbar
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.allHeaderTitle.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSection == section {
            switch selectedSection {
            case 0: return viewModel.getYears().count
            case 1: return viewModel.getGenres().count
            case 2: return viewModel.getDirectors().count
            case 3: return viewModel.getActors().count
            case 4: return viewModel.movies.count
            default: return 0
            }
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectedSection {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell", for: indexPath) as? OptionTableViewCell else { return UITableViewCell()}
            cell.setData(viewModel.getYears()[indexPath.row])
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell", for: indexPath) as? OptionTableViewCell else { return UITableViewCell()}
            cell.setData(viewModel.getGenres()[indexPath.row])
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell", for: indexPath) as? OptionTableViewCell else { return UITableViewCell()}
            cell.setData(viewModel.getDirectors()[indexPath.row])
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell", for: indexPath) as? OptionTableViewCell else { return UITableViewCell()}
            cell.setData(viewModel.getActors()[indexPath.row])
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell()}
            cell.setData(viewModel.movies[indexPath.row])
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.register(UINib(nibName: "OptionTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "OptionTableHeaderView")
        guard let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "OptionTableHeaderView") as? OptionTableHeaderView else { return UITableViewHeaderFooterView()}
        headerCell.setButtonTag(section)
        headerCell.setData(viewModel.allHeaderTitle[section])
        headerCell.expandButton.addTarget(self, action: #selector(expandButtonAction(_:)), for: .touchUpInside)
        return headerCell
    }
    @objc func expandButtonAction(_ sender: UIButton) {
        if sender.tag == selectedSection {
            selectedSection = nil
        } else {
            selectedSection = sender.tag
        }
        optionTableView.reloadData()
    }
}
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.allHeaderTitle[indexPath.section] == viewModel.allHeaderTitle.last {
            gotoMovieDetailViewController(viewModel.movies[indexPath.row])
        } else {
            if let searchText = getSelectedItem(indexPath) {
                gotoDetailViewController(searchText)
            }
        }
    }
    func getSelectedItem(_ selectedIndexPath: IndexPath ) -> String? {
        switch selectedIndexPath.section {
        case 0: return viewModel.getYears()[selectedIndexPath.row]
        case 1: return viewModel.getGenres()[selectedIndexPath.row]
        case 2: return viewModel.getDirectors()[selectedIndexPath.row]
        case 3: return viewModel.getActors()[selectedIndexPath.row]
        case 4: return nil
        default:
            return nil
        }
    }
}
extension HomeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let searchText = textField.text, !searchText.isEmpty {
            textField.text = ""
            gotoDetailViewController(searchText)
        }
    }
}
