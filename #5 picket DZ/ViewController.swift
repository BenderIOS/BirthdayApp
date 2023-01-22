//
//  ViewController.swift
//  #5 picket DZ
//
//  Created by Andrew on 07/01/23.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var switchMain: UISwitch!
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.isSecureTextEntry = true
        loginText.placeholder = "example@mail.com"
        passwordText.placeholder = "*******"
        
        switchMain.isOn = false
        
        switchMain.addTarget(self, action: #selector(faceIdSwitch(target: )),  for: .valueChanged)
        self.view.endEditing(true)
    }
    
    //Button "Глазок"
    @IBAction func eyeButton(_ sender: Any) {
        if passwordText.isSecureTextEntry {
            passwordText.isSecureTextEntry = false
        } else { passwordText.isSecureTextEntry = true}
    }
    
    // Функция основной кнопки (вход)
    @IBAction func startButton(_ sender: Any) {
        if loginText.text!.isEmpty || passwordText.text!.isEmpty || (passwordText.text != loginText.text) {
            let alert = UIAlertController(title: "Внимание", message: "Заполните данные верно", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
            self.present(alert, animated: true, completion: nil)
        } else {
            openNewScreen()
        }
    }
    
    
    // Метод фэйс айди
    @objc func faceIdSwitch(target: UISwitch) {
        
        if switchMain.isOn == true {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Please authenticate to proceed.") { success, error in
                    if success {
                        DispatchQueue.main.async {
                            print("Успешная авторизация")
                            self.openNewScreen()
                        }
                    }
                }
            } else {
                print("Face/Touch ID не найден")
            }
        }
    }
    
    // Метод открытия следующей вью
    func openNewScreen () {
//        let twoVC = UIStoryboard(name: "Main", bundle: nil)
//        guard let nextScreen = twoVC.instantiateViewController(withIdentifier: "twoVC") as? twoVC else {return}
        let vc = storyboard?.instantiateViewController(withIdentifier: "twoVC") as! twoVC
        self.navigationController?.pushViewController(vc, animated: true)
//        nextScreen.modalPresentationStyle = .fullScreen
//        self.show(nextScreen, sender: nil)
    }
    
    // Method Close keyboard
    func tapKeyboardOff () {
        loginText.resignFirstResponder()
        passwordText.resignFirstResponder()
    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        loginText.resignFirstResponder()
        passwordText.resignFirstResponder()
    }
}

