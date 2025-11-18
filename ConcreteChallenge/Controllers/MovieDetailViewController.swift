//
//  MovieDetailViewController.swift
//  ConcreteChallenge
//
//  Created by Karina on 07/03/23.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    let viewModel = MovieDetailViewModel()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestGenre()
        title = Constants.movieDetailScreen
        setUpTableView()
        setUpTableViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func setUpTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MovieDetailViewController: UITableViewDelegate {
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FirstMovieDetailCell.self, forCellReuseIdentifier: Constants.firstMovieCell)
        tableView.register(SecondMovieDetailCell.self, forCellReuseIdentifier: Constants.secondMovieCell)
        tableView.register(ThirdMovieDetailCell.self, forCellReuseIdentifier: Constants.thirdMovieCell)
        tableView.register(FourthMovieDetailCell.self, forCellReuseIdentifier: Constants.fourthMovieCell)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
}

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let moviesNew = viewModel.movies {
            switch indexPath.row {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.firstMovieCell, for: indexPath) as? FirstMovieDetailCell else { return UITableViewCell()}
                return viewModel.configureFirstCell(movie: moviesNew, cell: cell)
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.secondMovieCell, for: indexPath) as? SecondMovieDetailCell else { return UITableViewCell()}
                return viewModel.configureSecondCell(movie: moviesNew, cell: cell)
            case 2:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.thirdMovieCell, for: indexPath) as? ThirdMovieDetailCell else { return UITableViewCell()}
                return viewModel.configureThirCell(movie: moviesNew, cell: cell)
            case 3:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.fourthMovieCell, for: indexPath) as? FourthMovieDetailCell else { return UITableViewCell()}
                return viewModel.configureFourthCell(movie: moviesNew, cell: cell)
            default:
                return UITableViewCell()
        }
    }
        return UITableViewCell()
}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 400
        case 3:
            return 150
        default:
            return 50
        }
    }
}
