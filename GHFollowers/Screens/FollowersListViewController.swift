//
//  FollowersListViewController.swift
//  GHFollowers
//
//  Created by Victor Chang on 15/01/2024.
//

import UIKit

class FollowersListViewController: GFDataLoadingViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
    var page = 1
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewController()
        configCollectionView()
        getFollowers(username: username, page: page)
        configDataSource()
        configSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
 
    private func configViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
//    @objc func addButtonTapped() {
//
//        showLoadingView()
//        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
//            guard let self = self else { return }
//            self.dismissLoadingView()
//
//            switch result {
//            case .success(let user):
//                self.addUserToFavorites(user: user)
//            case .failure(let error):
//                self.presentGHAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
//            }
//        }
//    }
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                addUserToFavorites(user: user)
                dismissLoadingView()
            } catch {
                if let gfError = error as? GFError {
                    presentGHAlert(title: "Something went wrong", message: gfError.rawValue, buttonTitle: "OK")
                } else {
                    presentDefaultError()
                }
                dismissLoadingView()
            }
        }
    }
    
    private func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                DispatchQueue.main.async {
                    self.presentGHAlert(title: "Sucess!", message: "You have successfully added user to Favorites", buttonTitle: "Done")
                }
                return
            }
            DispatchQueue.main.async {
                self.presentGHAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        
        Task {
            
//           MARK: - This is the way
            do {
                let followers = try await NetworkManager.shared.getFollowers(for: username, page: page)
                self.updateUI(with: followers)
                dismissLoadingView()
            } catch {
                if let gfError = error as? GFError {
                    presentGHAlert(title: "Bad Stuff Happened", message: gfError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultError()
                }
                dismissLoadingView()
            }
            
            // MARK: - Simpler way, but with generic error handling
//            guard let follower = try await NetworkManager.shared.getFollowers(for: username, page: page) else {
//                presentDefaultError()
//                dismissLoadingView()
//                return
//            }
//            updateUI(with: followers)
//            dismissLoadingView()
        }
        
//        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
//            guard let self = self else { return }
//            self.dismissLoadingView()
//            switch result {
//            case .success(let followers):
//                self.updateUI(with: followers)
//            case .failure(let error):
//                self.presentGHAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
//            }
//            self.isLoadingMoreFollowers = false
//        }
    }
    
    private func updateUI(with followers: [Follower]) {
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them 😀."
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
            }
        }
        self.updateData(on: self.followers)
    }
    
    private func configCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: self.view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    private func configDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension FollowersListViewController: UICollectionViewDelegate {
    //MARK: - Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            self.getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destinationViewController = UserInfoViewController()
        destinationViewController.username = follower.login
        destinationViewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: destinationViewController)
        present(navigationController, animated: true)
    }
}

extension FollowersListViewController: UISearchResultsUpdating {
    // MARK: - Searchbar
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
}

extension FollowersListViewController: UserInfoViewControllerDelegate {
    
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        updateData(on: followers)
        getFollowers(username: username, page: page)
    }
}
