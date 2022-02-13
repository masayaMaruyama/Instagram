//
//  PostCommentViewController.swift
//  Instagram
//
//  Created by jobs steve on 2022/02/12.
//

import UIKit

class PostCommentViewController: UIViewController {

    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func commentPostButton(_ sender: Any) {

        
        
        
        
    }
    
    //キャンセルボタンのメソッド
    @IBAction func commentCancelButton(_ sender: Any) {
        //ホーム画面へ戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
