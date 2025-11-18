//
//  MovieTabBarController.swift
//  ConcreteChallenge
//
//  Created by Karina on 18/07/22.
//

import UIKit

class MovieTabBarController: UITabBarController {
    
    let mainView = MovieViewController()
    let favoriteView = FavoriteTabController()
    var favoriteController = UINavigationController()
    var navController = UINavigationController()
    let search = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpMovieControllerNav()
        setUpFavoriteControllerNav()
        setTabBar()
    }
    
    func setUpMovieControllerNav() {
        navController = UINavigationController(rootViewController: mainView)
        navController.navigationBar.isTranslucent = false
        UINavigationBar.appearance().backgroundColor = Colors.yellow
        
        navController.tabBarItem.title = Constants.title
        navController.tabBarItem.image = Constants.listIcon
        navController.tabBarItem.selectedImage = Constants.listIcon
        
        mainView.navigationItem.title = Constants.title
    }
    
    func setUpFavoriteControllerNav() {
        favoriteController = UINavigationController(rootViewController: favoriteView)
        favoriteController.navigationBar.isTranslucent = false
        UINavigationBar.appearance().backgroundColor = Colors.yellow
        
        favoriteController.tabBarItem.title = Constants.favoriteTitle
        favoriteController.tabBarItem.image = Constants.favoriteIconEmpty
        favoriteController.tabBarItem.selectedImage = Constants.favoriteIconEmpty
        
        favoriteView.navigationItem.title = Constants.title
    }
    
    func setTabBar() {
        
        tabBar.backgroundColor = Colors.yellow
        tabBar.tintColor = .black
        
        viewControllers = [navController, favoriteController]
    }

}
