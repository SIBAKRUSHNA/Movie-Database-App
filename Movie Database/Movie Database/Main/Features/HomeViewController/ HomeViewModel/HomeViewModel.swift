//
//  HomeViewModel.swift
//  Movie Database
//
//  Created by Siba Krushna Biswal on 26/07/24.
//

import UIKit

class HomeViewModel: NSObject {
    let allHeaderTitle = ["Year", "Genre", "Directors", "Actors", "All Movies"]
    var movies: [Movie] = []
    func loadMovies() {
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json") else {
            fatalError("Missing file: movies.json")
        }
        let data = try! Data(contentsOf: url)
        movies = try! JSONDecoder().decode([Movie].self, from: data)
    }
    func getYears() -> [String] {
        let years = movies.flatMap { $0.year.split(separator: "-").map { $0.trimmingCharacters(in: .whitespaces) } }
        let cleanedYears = years.flatMap { $0.separateYears()}.compactMap{$0}
        return Array(Set(cleanedYears)).sorted()
    }
    func getGenres() -> [String] {
        let genres = movies.flatMap { $0.genre.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) } }
        let uniqueGenres = Set(genres)
        return Array(uniqueGenres).sorted()
    }
    func getDirectors() -> [String] {
        let directors = movies.flatMap { $0.director.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) } }
        let filteredDirector = directors.filter { $0 != "N/A" }
        let uniqueDirectors = Set(filteredDirector)
        return Array(uniqueDirectors).sorted()
    }
    func getActors() -> [String] {
        let actors = movies.flatMap { $0.actors.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) } }
        let filteredActors = actors.filter { $0 != "N/A" }
        let uniqueActors = Set(filteredActors)
        return Array(uniqueActors).sorted()
    }
}
