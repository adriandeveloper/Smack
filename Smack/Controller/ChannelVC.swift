//
//  ChannelVC.swift
//  Smack
//
//  Created by Adrian Thomas on 12/9/17.
//  Copyright © 2017 Adrian Thomas. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

  // Outlet
  @IBOutlet weak var loginBtn: UIButton!
  @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
    
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // sets how much of the back view controller is shown. 
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }


  @IBAction func loginBtnPressed(_ sender: Any) {
    performSegue(withIdentifier: TO_LOGIN, sender: nil)
  }
  
}
