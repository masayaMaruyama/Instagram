//
//  LoginViewController.swift
//  Instagram
//
//  Created by jobs steve on 2022/01/20.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    //LoginButtonMethod:ログインButton
    @IBAction func handleLoginButton(_ sender: Any) {
        if let address = mailAddressTextField.text, let password = passwordTextField.text {
            
            //アドレスとパスワード名のいずれかでも入力されていない時は何もしない
            if address.isEmpty || password.isEmpty {
                SVProgressHUD.showError(withStatus: "必要項目を入力してちょ")
                return
            }
            
            SVProgressHUD.show() //HUD.Show
            
            Auth.auth().signIn(withEmail: address, password: password) { authResult, error in
                if let error = error {
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "サインインに失敗ぽ")
                    return
                }
                print("DEBUG_PRINT: ログインに成功。")
                
                SVProgressHUD.dismiss() //HUD delete
                
                //画面を閉じてタブ画面を閉じる
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    //CreateAccountButtonMethod：アカウント作成Button
    @IBAction func handleCreateAccountButton(_ sender: Any) {
        if let address = mailAddressTextField.text, let password = passwordTextField.text, let displayName = displayNameTextField.text {
            
            //アドレスとパスワードと表示名のいずれかでも入力されていない時は何もしない
            //3項目のいずれかの文字列が空かをisEmptyで識別
            if address.isEmpty || password.isEmpty || displayName.isEmpty {
                print("DEBUG_PRINT: 何かが空文字です。")
                SVProgressHUD.showError(withStatus: "必要項目を入力せい")
                return
            }
            
            SVProgressHUD.show()
            
            //Auth.auth().createUser(withEmail: address, password: password, completion: { authResult, error in
            // クロージャ内の処理 })
            
            //アドレスとパスワードでユーザー作成。ユーザー作成に成功すると、自動的にログインする
            Auth.auth().createUser(withEmail: address, password: password) { authResult, error in
                if let error = error{ //nilチェックでエラーかを識別してアンラップ(if letにてnilじゃない場合の処理を下記記述)
                    print("DEBUG_PRINT: " + error.localizedDescription) //エラー(nilじゃない)の場合は原因をprint
                    return //returnで処理を終了させる
                }
                print("DEBUG_PRINT: ユーザー作成に成功しました。")
                
                //表示名(displayName)を設定する
                let user = Auth.auth().currentUser
                if let user = user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = displayName
                    changeRequest.commitChanges { error in
                        if let error = error {
                            //プロフィールの更新でエラーが発生
                            print("DEBUG_PRINT: " + error.localizedDescription) //DEBUG_PRINT
                            SVProgressHUD.showError(withStatus: "表示名の設定に失敗したよ")
                            return //errorはreturnで処理を終了させる
                        }
                        print("DEBUG_PRINT: [displayName = \(user.displayName!)]の設定に成功しました。")
                        
                        SVProgressHUD.dismiss() //HUD delete
                        
                        //LoginViewControllerを閉じてタブ画面に戻る
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

