//
//  ChatVC.swift
//  Smack
//
//  Created by Adrian Thomas on 12/9/17.
//  Copyright © 2017 Adrian Thomas. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
  
  // Outlets
  @IBOutlet weak var menuBtn: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
      self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
      self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
      
    }



}
