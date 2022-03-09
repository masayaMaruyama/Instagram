//
//  PostCommentViewController.swift
//  Instagram
//  Created by jobs steve on 2022/02/12.
import UIKit
import SVProgressHUD
import Firebase

class PostCommentViewController: UIViewController {
    var postDataId: String = ""
    var postDataCaption: String = ""
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBAction func commentPostButton(_ sender: Any) {
        
        let commentText = self.commentTextField.text!
        // ユーザー名を加えたコメントメッセージを組み立て
        let name = Auth.auth().currentUser!.displayName!
        let comment = "\(name) : \(commentText)"
        let updateValue = FieldValue.arrayUnion([comment])
        let postRef = Firestore.firestore().collection(Const.PostPath).document(postDataId)
        postRef.updateData(["comment": updateValue])
        
        //HUDで投稿完了を表示
        SVProgressHUD.showSuccess(withStatus: "コメント\n投稿しました")
        //投稿処理が完了したので先頭画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    //キャンセルボタンのメソッド(ホーム画面へ戻る)
    @IBAction func commentCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captionLabel.text = postDataCaption
        
        
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postDataId + ".jpg")
        postImageView.sd_setImage(with: imageRef)
        
    }
    
}
