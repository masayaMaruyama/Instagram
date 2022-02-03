//
//  SettingViewController.swift
//  Instagram
//
//  Created by jobs steve on 2022/01/20.
//

import UIKit
import Firebase
import SVProgressHUD

class SettingViewController: UIViewController {
    @IBOutlet weak var displayNameTextField: UITextField!
    //表示名を変更Button(handleChangeButton)
    @IBAction func handleChangeButton(_ sender: Any) {
        if let displayName = displayNameTextField.text {
            //表示名が入力されていない時はHUDを出して何もしない
            if displayName.isEmpty {
                SVProgressHUD.showError(withStatus: "表示名を入力して下さい")
                return
            }
            //表示名を設定する
            let user = Auth.auth().currentUser
            if let user = user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = displayName
                changeRequest.commitChanges { error in
                    if let error = error {
                        SVProgressHUD.showError(withStatus: "表示名の変更に失敗しました。")
                        print("DEBUG_PRINT: " + error.localizedDescription)
                        return
                    }
                    print("DEBUG_PRINT: [displayName = \(user.displayName!)]の設定に成功しました。" )
                    
                    //HUDで完了を知らせる
                    SVProgressHUD.showSuccess(withStatus: "表示名を変更しました")
                }
            }
        }
        self.view.endEditing(true) //キーボードを閉じる
    }
    //ログアウトButton(handleLogoutButton)
    @IBAction func handleLogoutButton(_ sender: Any) {
        //Logout
        try! Auth.auth().signOut()

        //ログイン画面を表示
        //遷移先を指定
        let loginViewController = self.storyboard?.instantiateViewController(identifier: "Login")
        //presentを使用して引数を指定(presentで画面遷移)
        self.present(loginViewController!, animated: true, completion: nil)
        
        //ログイン画面から戻ってきた時のためにホーム画面（index = 0）を選択している状態にしておく
        tabBarController?.selectedIndex = 0
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //表示名を取得してTextFieldに設定する
        let user = Auth.auth().currentUser
        //右のuserがnilでない場合、アンラップした{処理}が代入される。(nilチェック+アンラップ+処理)
        //代入する変数or定数は同じ名前が使用できる。(アンラップしたいだけだから)
        if let user = user {
            displayNameTextField.text = user.displayName
        }
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
