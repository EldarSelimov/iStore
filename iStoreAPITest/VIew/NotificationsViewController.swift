//
//  NotificationsViewController.swift
//  iStoreAPITest
//
//  Created by Eldar on 05.08.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var notifications: [NotificationModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        NetworkManager.shared.getNotifications(succes: { [weak self] (result) in
            self?.notificationsLoaded(result)
        }) { [weak self] (error) in
            let alert = UIAlertController(title: "Ошибка!", message: error, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    private func notificationsLoaded(_ items: [NotificationModel]) {
        self.notifications = items
        
        activityIndicator.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension NotificationsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationTableViewCell
        
        let notification = notifications[indexPath.row]
        cell.configure(with: notification)
        
        return cell
    }
    
}
