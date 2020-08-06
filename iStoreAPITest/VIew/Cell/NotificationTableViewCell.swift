//
//  NotificationTableViewCell.swift
//  iStoreAPITest
//
//  Created by Eldar on 05.08.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import Kingfisher

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var titleIconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var notificationImageView: UIImageView!
    @IBOutlet weak var notificationDescription: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    private var linkURL = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        shadowView.layer.cornerRadius = 10
        shadowView.layer.applySketchShadow(color: .black, alpha: 0.12, x: 0, y: 0, blur: 15, spread: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleIconImageView.layer.cornerRadius = titleIconImageView.frame.height / 2
    }
    
    func configure(with notification: NotificationModel) {
        titleIconImageView.kf.setImage(with: URL(string: notification.titleImage))
        titleLabel.text = notification.title
        
        notificationImageView.kf.setImage(with: URL(string: notification.notificationImage))
        notificationDescription.text = notification.notificationDescription
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        var date = dateFormatter.date(from: notification.date) ?? Date()
        date.addTimeInterval(3600 * 3)
        
        let stringFormatter = DateFormatter()
        stringFormatter.dateFormat = "dd MMMM"
        
        let stringDate = stringFormatter.string(from: date)
        
        dateTimeLabel.text = stringDate + ", \(notification.time)"
        
        linkURL = notification.link
    }
    
    @IBAction func actionOpenInInstragram(_ sender: Any) {
        if let url = URL(string: linkURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
