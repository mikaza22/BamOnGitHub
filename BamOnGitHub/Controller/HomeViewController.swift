//
//  FirstViewController.swift
//  BamOnGitHub
//
//  Created by Geraldine on 09/07/2020.
//  Copyright © 2020 Geraldine. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    /**
     call function from the API
     */
    let api = APIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.getRepositories() { (data: [GitHubRepository]) in
            print(data)
        }
    }
    
    
}

