//
//  TabBarController.swift
//  Instagram
//
//  Created by jobs steve on 2022/01/22.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //tabBar.tintColor:アイコンの色
        self.tabBar.tintColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
        //tabBar.barTintColor:背景色
        self.tabBar.barTintColor = UIColor(red: 0.96, green: 0.91, blue: 0, alpha: 1)
        //UITabBarControllerDelegateプロトコルのメソッドをこのクラスで処理
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        //判定：切り替え先の画面が ImageSelectViewControllerクラスかどうか分岐して、真ん中のカメラのボタンが押されたかを判定
        if viewController is ImageSelectViewController {
            // ImageSelectViewControllerは、タブ切り替えではなくモーダル画面遷移する(falseで返すとタブ切り替えは行われません。)
            let imageSelectViewController = storyboard!.instantiateViewController(withIdentifier: "ImageSelect")
            //モーダル画面遷移を行う
            present(imageSelectViewController, animated: true)
            return false
        } else {
            // その他のViewControllerは通常のタブ切り替えを実施(trueは通常のタブ切り替え)
            return true
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
