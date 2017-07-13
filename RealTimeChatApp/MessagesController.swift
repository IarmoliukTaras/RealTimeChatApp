//
//  MessagesController.swift
//  RealTimeChatApp
//
//  Created by 123 on 11.07.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MessagesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "new_message_icon"), style: .plain, target: self, action: #selector(handleNewMessage))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        checkIfUserLoggedIn()
        
    }
    
    func handleNewMessage() {
        let newMessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    
    func checkIfUserLoggedIn() {
        let userUid = FIRAuth.auth()?.currentUser?.uid
        if userUid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            
            FIRDatabase.database().reference().child("users").child(userUid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                self.navigationItem.title = dictionary["name"] as? String
                print(snapshot)
            })
        }
    }
    
    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }


}

