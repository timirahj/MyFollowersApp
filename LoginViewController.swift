//
//  LoginViewController.swift
//  
//
//  Created by Timirah James on 5/3/17.
//
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logOutBuuton: UIButton!
    @IBOutlet weak var showFollowers: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        if let session = Twitter.sharedInstance().sessionStore.session() {
            let client = TWTRAPIClient()
            client.loadUser(withID: session.userID) { (user, error) -> Void in
                if let user = user {
                    self.userLabel.text = ("@\(user.screenName)") + " is currently logged in."
                }
                
                if (session != nil) {
                    
                    self.showFollowers.isEnabled = true
                    
                } else {
                    self.showFollowers.isEnabled = false
                    self.userLabel.text = "Please log in to continue."
                }
                
                
                
            }
            

        }
   
    
}
    
    func showRecentFollowers(){
        
      
        self.performSegue(withIdentifier: "showFollowers", sender: nil)
        
    }
    
    
    
    @IBAction func login(_ sender: Any) {
        
        Twitter.sharedInstance().logIn { session, error in
            if (session != nil) {
                print("signed in as \(session?.userName)")
                print(session?.userID)
                print(session?.userName)
                print(session?.authToken)
                print(session?.authTokenSecret)
                
                self.userLabel.text = "signed in as \(session!.userName)"
                self.showFollowers.isEnabled = true
                
            } else {
                print("Login error: %@", error!.localizedDescription);
                self.userLabel.text = "Please log in to continue."
            }
        }
        
    }
    
    
    
    
@IBAction func logOut(_ sender: Any) {
    
    let store = Twitter.sharedInstance().sessionStore
    
    if let userID = store.session()?.userID {
        store.logOutUserID(userID)
        
        print("logged out")
    }
    
    print(store.session()?.userID as Any)
    
    self.showFollowers.isEnabled = false
    self.userLabel.text = "You are signed out. Please log in to continue."
    
}
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
