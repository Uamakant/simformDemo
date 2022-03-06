//
//  TabbarVC.swift
//  simformdemo


import UIKit

class TabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Sign Out", style: .plain, target: self, action: #selector(self.signout))

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signout(){
        
        let isSigout = KeyChain.delete(key: kUSER_KEY)
        if isSigout{
            self.makeRootViewController(viewControllerName: "LoginVC")
        }
        
    }
  
    func makeRootViewController(viewControllerName:String){
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: viewControllerName)
        let navController = UINavigationController(rootViewController: viewController)
        UIApplication.shared.windows.first?.rootViewController = navController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }


}
