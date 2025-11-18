//
//  MovieController.swift
//  ConcreteChallenge
//
//  Created by Karina on 13/07/22.
//

import UIKit

class MovieViewController: UIViewController {
    
    var filteredMovies = [MoviesData]()
    let viewModel = MovieViewModel()
    let component = ErrorView()
    let searchController = UISearchController()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setUpCollection()
        setUpSearchController()
        setUpBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.hidesSearchBarWhenScrolling = false
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func setUpBinding() {
        viewModel.requestMovies { fetched in
            if fetched {
                self.filteredMovies = self.viewModel.movies
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.setComponent(withText: Constants.errorText, andImage: Constants.errorImage)
                    self.setUpComponentConstraint()
                    self.showComponent()
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func setUpComponentConstraint() {
        NSLayoutConstraint.activate([
            component.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            component.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            component.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            component.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    func setComponent(withText: String, andImage: UIImage?) {
        //send boolean as parameter to set the hidden
        let config = ErrorViewInformation(label: withText, errorImage: andImage)
        component.setUpItems(with: config)
        component.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(component)
        component.isHidden = true
        setUpComponentConstraint()
    }
    
    func showComponent() {
        component.isHidden = false
        collectionView.isHidden = true
    }
    
    func hideComponent() {
        component.isHidden = true
        collectionView.isHidden = false
    }
    
    @objc func reload() {
        viewModel.requestMovies { fetched in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
}

extension MovieViewController: UICollectionViewDelegate {
    func setUpCollection() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reload))
        
        //MARK: - Delegates
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MovieCollectionCell.self, forCellWithReuseIdentifier: Constants.collectionIdentifier)
        view.addSubview(collectionView)
    }
}

extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionIdentifier, for: indexPath) as? MovieCollectionCell else { return UICollectionViewCell() }
        return viewModel.configureMovieCell(with: filteredMovies, indexPath: indexPath, movieCell: cell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.viewModel.movies = viewModel.movies[indexPath.row]
        navigationController?.pushViewController(vc, animated: true )
    }
}

extension MovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionSize(with: collectionView.frame.size.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
    }
}

extension MovieViewController: UISearchBarDelegate {
    func setUpSearchController() {
        navigationItem.searchController = searchController
        setDelegates()
    }
    
    func setDelegates() {
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMovies = []
        if searchText != String() {
            filteredMovies = viewModel.movies.filter{$0.title.lowercased().contains(searchText.lowercased())}
        } else {
            filteredMovies = viewModel.movies
        }
        
        
        //        let emptyText = searchText.replacingOccurrences(of: " ", with: "")
        //        if filteredMovies.isEmpty && emptyText != "" {
        //            filteredMovies = viewModel.movies.filter{!$0.title.lowercased().contains(searchText.lowercased()) }
        //            setComponent(withText: "Sua busca por \(searchText) não foi encontrada", andImage: Constants.errorImage)
        //            showComponent()
        //        } else {
        //
        //            hideComponent()
        //
        //        }
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideComponent()
        filteredMovies.removeAll()
        filteredMovies = viewModel.movies
        collectionView.reloadData()
    }
}

