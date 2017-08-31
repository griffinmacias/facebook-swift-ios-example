//
//  UserInfoView.swift
//  fb-info
//
//  Created by Mason Macias on 8/30/17.
//  Copyright © 2017 griffinmacias. All rights reserved.
//

import UIKit

class UserInfoView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        self.clipsToBounds = true
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        self.addSubview(self.containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let margins = self.layoutMarginsGuide
        containerView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
    }
}
