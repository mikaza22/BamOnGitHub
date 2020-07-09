//
//  FirstViewController.swift
//  BamOnGitHub
//
//  Created by Geraldine on 09/07/2020.
//  Copyright © 2020 Geraldine. All rights reserved.
//

import UIKit
import CoreData

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
    
    /**
     Pull to refresh
     */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.2156862745, green: 0.5529411765, blue: 0.1960784314, alpha: 1)
        return refreshControl
    }()
    
    // MARK: - overrided functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.repositoryListTableView.dataSource = self
        self.repositoryListTableView.refreshControl = refreshControl
        self.repositoryListTableView.accessibilityIdentifier = "repositoryList"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getRepositoryList()
    }
    
    // MARK: - HomeViewController functions
    
    func getRepositoryList() {
        api.getRepositories() { (data: [GitHubRepository], error: Error?) in
            if error == nil {
                self.repositories = data
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.repositoryListTableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    let ErrorAlert = UIAlertController(title: "Can't retrieve repositories", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    
                    let dismiss = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                    
                    ErrorAlert .addAction(dismiss)
                    
                    self.present(ErrorAlert , animated: true) {
                        self.refreshControl.endRefreshing()
                    }
                }
            }
        }
    }
    
    @objc private func handleRefresh(_ sender: Any) {
        self.getRepositoryList()
    }
    /**
     * Open selected repository
     - Parameter sender: Link Button
     */
    @objc func buttonLinkClicked(sender: UIButton) {
        if let link = self.repositories[sender.tag].html_url, let url = URL(string:link)  {
            UIApplication.shared.open(url)
        }
    }
    
    /**
     * Add selected repository to favorites
     - Parameter sender: Fav Button
     */
    @objc func buttonFavClicked(sender: UIButton) {
        self.addTofav(index: sender.tag)
    }
    
    /**
    * Add repository to fav with CoreData
    - Parameter index: index of the repository selected
    */
    func addTofav(index: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "Fav", in: managedContext)!
        
        let fav = NSManagedObject(entity: userEntity, insertInto: managedContext)
        let repository = self.repositories[index]
        if let name = repository.name, let link = repository.html_url {
            fav.setValue(name, forKey: "name")
            fav.setValue(link, forKey: "link")
        }
        do {
            try managedContext.save()
           
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
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
        cell.repositoryLinkButton.tag = indexPath.row
        cell.repositoryFavButton.addTarget(self, action: #selector(buttonFavClicked(sender:)), for: .touchUpInside)
        cell.repositoryFavButton.tag = indexPath.row
        return cell
    }
}

