//
//  ViewController.swift
//  RealTimeChatApp
//
//  Created by 123 on 11.07.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    func handleLogout() {
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }


}

