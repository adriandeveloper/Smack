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
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  // Variables
  var avatarName = "profileDefault"
  var avatarColor = "[0.5,0.5,0.5, 1]"
  var bgColor : UIColor?
  
  override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
  
  // Update avatar image to the one selected
  override func viewDidAppear(_ animated: Bool) {
    if UserDataService.instance.avatarName != "" {
      usrImg.image = UIImage(named: UserDataService.instance.avatarName)
      avatarName = UserDataService.instance.avatarName
      if avatarName.contains("light") && bgColor == nil {
        usrImg.backgroundColor = UIColor.lightGray
      }
    }
  }
  
  // Go back to rooms screen once you close from the Create account VC
  @IBAction func closePressed(_ sender: Any) {
    performSegue(withIdentifier: UNWIND, sender: nil)
  }
  
  @IBAction func createAcctPressed(_ sender: Any) {
    // toggle and animate activity spinner
    spinner.isHidden = false
    spinner.startAnimating()

    guard let name = usernameTxt.text, usernameTxt.text != "" else { return }
    guard let email = emailTxt.text, emailTxt.text != "" else { return }
    guard let password = passwdTxt.text, passwdTxt.text != "" else { return }
    
    AuthService.instance.registerUser(email: email, password: password) { (success) in
      if success {
        AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
          if success {
            AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
              if success {
                // toggle and stop spinner animation
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                
                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                self.shouldPerformSegue(withIdentifier: UNWIND, sender: nil)
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
              }
            })
          }
        })
      }
    }
  }
  @IBAction func pickAvatarPressed(_ sender: Any) {
    performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
  }
  @IBAction func pickBGColorPressed(_ sender: Any) {
    let r = CGFloat(arc4random_uniform(255)) / 255
    let g = CGFloat(arc4random_uniform(255)) / 255
    let b = CGFloat(arc4random_uniform(255)) / 255
    
    bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
    UIView.animate(withDuration: 0.2) {
       self.usrImg.backgroundColor = self.bgColor
    }
   
  }
  
  func setupView() {
    spinner.isHidden = true
    usernameTxt.attributedPlaceholder = NSAttributedString(
      string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
    emailTxt.attributedPlaceholder = NSAttributedString(
      string: "email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
    passwdTxt.attributedPlaceholder = NSAttributedString(
      string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
    view.addGestureRecognizer(tap)
  }
  
  @objc func handleTap() {
    view.endEditing(true)
  }
}
