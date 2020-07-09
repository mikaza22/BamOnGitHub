//
//  FirstViewController.swift
//  BamOnGitHub
//
//  Created by Geraldine on 09/07/2020.
//  Copyright © 2020 Geraldine. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var repositoryListTableView: UITableView!
    
    // MARK: - Properties
    
    /**
     call function from the API
     */
    let api = APIClient()
    
    /**
     Store GitHub repositories data
     */
    var repositories: [GitHubRepository] = []
    
    // MARK: - overrided functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.repositoryListTableView.dataSource = self
        api.getRepositories() { (data: [GitHubRepository]) in
            self.repositories = data
            DispatchQueue.main.async {
                self.repositoryListTableView.reloadData()
            }
        }
    }
    
    // MARK: - HomeViewController functions
    
    /**
     * Open selected repository
     - Parameter sender: Link Button
     */
    @objc func buttonLinkClicked(sender: UIButton) {
        print("Button Link clicked")
    }
    
    /**
     * Add selected repository to favorites
     - Parameter sender: Fav Button
     */
    @objc func buttonFavClicked(sender: UIButton) {
        print("Button Fav clicked")
    }
}

// MARK: - Extension : TableView DataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryListCell") as! RepositoryListTableViewCell
        
        let repository = self.repositories[indexPath.row]
        cell.repositoryNameLabel.text = repository.name
        cell.repositoryLinkButton.addTarget(self, action: #selector(buttonLinkClicked(sender:)), for: .touchUpInside)
        cell.repositoryFavButton.addTarget(self, action: #selector(buttonFavClicked(sender:)), for: .touchUpInside)
        return cell
        
    }
}

