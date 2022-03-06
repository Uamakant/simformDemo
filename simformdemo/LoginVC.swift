//
//  LoginVC.swift
//  simformdemo


import UIKit

class LoginVC: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var txtUserName:UITextField!
    @IBOutlet weak var txtPassword:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func onClickLogin(_ sender:UIButton!){
        self.view.endEditing(true)
        
        if txtUserName.text?.count == 0{
            showAlert(msg: "Please enter user name")
        }
        else if txtPassword.text?.count == 0{
            showAlert(msg: "Please enter password")
        }
        else{
            let dict = ["Username" : txtUserName.text,
                        "Password" : txtPassword.text]
            
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
               
                let status = KeyChain.save(key: kUSER_KEY, data: jsonData)
                print("status: ", status)
                    
                if let receivedData = KeyChain.load(key: kUSER_KEY) {
                    let decoded = try JSONSerialization.jsonObject(with: receivedData, options: [])
                    print("result: ", decoded)
                    self.makeRootViewController(viewControllerName: "TabbarVC")
                }

            } catch {
                print(error.localizedDescription)
            }
        }
        
        
       
        
    }
    
    func showAlert(msg: String){
        
        let alert = UIAlertController.init(title: "", message: msg, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func makeRootViewController(viewControllerName:String){
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: viewControllerName)
        let navController = UINavigationController(rootViewController: viewController)
        UIApplication.shared.windows.first?.rootViewController = navController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

}
