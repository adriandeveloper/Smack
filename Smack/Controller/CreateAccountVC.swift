//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Adrian Thomas on 12/10/17.
//  Copyright © 2017 Adrian Thomas. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    // Outlets
  @IBOutlet weak var usernameTxt: UITextField!
  @IBOutlet weak var emailTxt: UITextField!
  @IBOutlet weak var passwdTxt: UITextField!
  
  @IBOutlet weak var usrImg: UIImageView!
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
  // Go back to rooms screen once you close from the Create account VC
  @IBAction func closePressed(_ sender: Any) {
    performSegue(withIdentifier: UNWIND, sender: nil)
  }
  
  @IBAction func createAcctPressed(_ sender: Any) {
    guard let email = emailTxt.text, emailTxt.text != "" else { return }
    guard let password = passwdTxt.text, passwdTxt.text != "" else { return }
    
    AuthService.instance.registerUser(email: email, password: password) { (success) in
      if success {
        print("registered user!")
      }
    }
  }
  @IBAction func pickAvatarPressed(_ sender: Any) {
  }
  @IBAction func pickBGColorPressed(_ sender: Any) {
  }
  
  
}
