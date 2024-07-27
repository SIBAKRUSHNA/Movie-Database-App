//
//  DetailViewModel.swift
//  Movie Database
//
//  Created by Siba Krushna Biswal on 26/07/24.
//

import UIKit

class DetailViewModel: NSObject {
    var movies: [Movie] = []
    var searchText: String?
    func loadMovies() {
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json") else {
            fatalError("Missing file: movies.json")
        }
        let data = try! Data(contentsOf: url)
        movies = try! JSONDecoder().decode([Movie].self, from: data)
    }
    func filterMovies() -> [Movie] {
        return movies.filter { movie in
            let movieAllStrings = getMovieStrings(movie)
            return movieAllStrings.contains { $0.lowercased() == searchText?.lowercased() }
        }
    }
    func getMovieStrings(_ movie: Movie) -> [String] {
        var allString = [String]()
        allString.append(contentsOf: getYears(movie))
        allString.append(contentsOf: getGenres(movie))
        allString.append(contentsOf: getDirectors(movie))
        allString.append(contentsOf: getActors(movie))
        return allString
    }
    func getYears(_ movie: Movie) -> [String] {
        return movie.year.separateYears().compactMap{$0}
    }
    func getGenres(_ movie: Movie) -> [String] {
        let genres = movie.genre.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        let uniqueGenres = Set(genres)
        return Array(uniqueGenres)
    }
    func getDirectors(_ movie: Movie) -> [String] {
        let directors = movie.director.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        let filteredDirector = directors.filter { $0 != "N/A" }
        let uniqueDirectors = Set(filteredDirector)
        return Array(uniqueDirectors)
    }
    func getActors(_ movie: Movie) -> [String] {
        let actors = movie.actors.split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        let filteredActors = actors.filter { $0 != "N/A" }
        let uniqueActors = Set(filteredActors)
        return Array(uniqueActors)
    }
}
