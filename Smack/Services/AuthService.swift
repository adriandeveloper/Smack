//
//  AuthService.swift
//  Smack
//
//  Created by Adrian Thomas on 12/10/17.
//  Copyright © 2017 Adrian Thomas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
  static let instance = AuthService()
  
  let defaults = UserDefaults.standard
  
  // Auth service variables isLoggedIn, authToken, and userEmail
  var isLoggedIn : Bool {
    get {
      return defaults.bool(forKey: LOGGED_IN_KEY)
    }
    set {
      defaults.set(newValue, forKey: LOGGED_IN_KEY)
    }
  }
  
  var authToken: String {
    get {
      return defaults.value(forKey: TOKEN_KEY) as! String
    }
    set {
      defaults.set(newValue, forKey: TOKEN_KEY)
    }
  }
  
  var userEmail: String {
    get {
      return defaults.value(forKey: USER_EMAIL) as! String
    }
    set {
      defaults.set(newValue, forKey: USER_EMAIL)
    }
  }
  
  // MARK: Handle user registration
  func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
    
    let lowerCaseEmail = email.lowercased()

    let body: [String: Any] = [
      "email": lowerCaseEmail,
      "password": password
    ]
    
    // create web request
    Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
      if response.result.error == nil {
        completion(true)
      } else {
        completion(false)
        debugPrint(response.result.error as Any)
      }
    }
  }
  
  // MARK: Handle user login
  func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
    
    let lowerCaseEmail = email.lowercased()
    
    let body: [String: Any] = [
      "email": lowerCaseEmail,
      "password": password
    ]
    
    // login web request
    Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
      
      // handle login request
      if response.result.error == nil {
        // one way of handling usr login requests. Traditional way
//        if let json = response.result.value as? Dictionary<String, Any> {
//          if let email = json["user"] as? String {
//            self.userEmail = email
//          }
//          if let token = json["token"] as? String {
//            self.authToken = token
//          }
//        }
        
        // Using SwiftyJSON
        guard let data = response.data else { return }
        do {
          let json = try JSON(data: data)
          self.userEmail = json["user"].stringValue
          self.authToken = json["token"].stringValue
        } catch {
          debugPrint(error)
        }

        
        
        self.isLoggedIn = true
        completion(true)
      } else {
        completion(false)
        debugPrint(response.result.error as Any)
      }
    }
  }
  
  
  
  
  
  
  
  
  
  
}
