//
//  AppDelegate.swift
//  simformdemo
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
            
        
        do {
           
            if let receivedData = KeyChain.load(key: kUSER_KEY) {

                let decoded = try JSONSerialization.jsonObject(with: receivedData, options: [])
                print("result: ", decoded)
                self.makeRootViewController(viewControllerName: "TabbarVC")
            }
            else{
                
                self.makeRootViewController(viewControllerName: "LoginVC")
            }

        } catch {
            print(error.localizedDescription)
        }
        
        return true
    }
    
    
    func makeRootViewController(viewControllerName:String){
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: viewControllerName)
        let navController = UINavigationController(rootViewController: viewController)
        UIApplication.shared.windows.first?.rootViewController = navController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}



