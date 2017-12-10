//
//  ChannelVC.swift
//  Smack
//
//  Created by Adrian Thomas on 12/9/17.
//  Copyright © 2017 Adrian Thomas. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // sets how much of the back view controller is shown. 
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }


}
