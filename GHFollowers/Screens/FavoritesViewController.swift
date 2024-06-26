//
//  FavoritesViewController.swift
//  GHFollowers
//
//  Created by Victor Chang on 14/01/2024.
//

import UIKit

class FavoritesViewController: GFDataLoadingViewController {
    
    let tableView = UITableView()
    var favorites = [Follower]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        configTableView()
    }
    
    private func config() {
        view?.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
        tableView.removeExcessCells()
    }
    
    private func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentGHAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
                }
            }
        }
    }
    
    private func updateUI(with favorites: [Follower]) {
        if favorites.isEmpty {
            self.showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen", in: self.view)
        } else {
            self.favorites = favorites
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }

    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destinationViewController = FollowersListViewController(username: favorite.login)
        
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            self.presentGHAlert(title: "Unable to remove", message: error.rawValue, buttonTitle: "OK")
        }
    }
}
