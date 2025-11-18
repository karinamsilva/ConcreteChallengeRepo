//
//  FavoriteTabController.swift
//  ConcreteChallenge
//
//  Created by Karina on 18/07/22.
//

import UIKit

class FavoriteTabController: UIViewController {
    
    var filteredMovies = [MoviesData]()
    let viewModel = FavoriteViewModel()
    let searchBar = UISearchBar()
    
    let searchController = UISearchController()
    let tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
        viewModel.loadSavedMovies()
        filteredMovies = viewModel.savedMovies
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.showsCancelButton = true
        setUpSearchController()
        setUpTableView()
        setUpTableViewConstraints()
    }
    
    func setUpTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension FavoriteTabController: UITableViewDelegate {
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: Constants.favoritesTableViewIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
}

extension FavoriteTabController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.favoritesTableViewIdentifier, for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell()}
        return viewModel.configureMovieCell(with: filteredMovies, indexPath: indexPath, movieCell: cell)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteMovie(movie: filteredMovies[indexPath.row])
            filteredMovies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = MovieDetailViewController()
        controller.viewModel.movies = filteredMovies[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func deleteMovie(movie: MoviesData) {
        viewModel.deleteMovie(selectedMovie: movie)
    }
}

extension FavoriteTabController: UISearchBarDelegate {
    func setUpSearchController() {
        navigationItem.searchController = searchController
        setDelegates()
    }
    
    func setDelegates() {
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMovies = []
        filteredMovies = viewModel.savedMovies.filter{$0.title.lowercased().contains(searchText.lowercased())}
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.loadSavedMovies()
        filteredMovies = viewModel.savedMovies
        tableView.reloadData()
    }
}
