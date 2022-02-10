//
//  PostViewController.swift
//  Instagram
//  Created by jobs steve on 2022/01/20.
import UIKit
import Firebase
import SVProgressHUD
class PostViewController: UIViewController {
    //ImSeViConからモーダルで表示される際にUIImageを受け取ることができるように定義
    var image: UIImage!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBAction func handlePostButton(_ sender: Any) {//投稿Button
        //画像をJPEG形式に変換
        let imageData = image.jpegData(compressionQuality: 0.75)
        //画像と投稿データの保存場所を定義
        //Firestoreに保存する投稿データの保存場所を定義
        //Const.swiftで定義した PostPathを collection(_:)メソッドの引数に指定することで
        //Firestoreの postsフォルダに新しい投稿データを保存するよう指定
        let postRef = Firestore.firestore().collection(Const.PostPath).document()
        //Storageに保存する画像の保存場所を定義
        //Const.swiftで定義した ImagePathを child(_:)メソッドの引数に指定。
        //どの投稿に対応する画像か紐付けるために、 .child(postRef.documentID + ".jpg")を指定して
        //投稿データの documentIDを画像のファイル名に利用しています。
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postRef.documentID + ".jpg")
        SVProgressHUD.show()//HUDで投稿処理中の表示を開始
        //Storageに画像をアップロードする
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        //putData(_:meta〜)メソッドで画像をStorageにアップロード
        imageRef.putData(imageData!, metadata: metadata) { (metadate, error) in
            if error != nil {//画像のアップロード失敗
                print(error!)
                SVProgressHUD.showError(withStatus: "画像のアップロードが失敗しました")
                //投稿処理をキャンセルし、先頭画面に戻る(先頭画面へ戻るコード)
                UIApplication.shared.windows.first{ $0.isKeyWindow}?.rootViewController?.dismiss(animated: true, completion: nil)
                return
            }
            //FireStoreに投稿データを保存する（setData(_:)メソッド）
            let name = Auth.auth().currentUser?.displayName
            let postDic = [
                "name": name!,
                "caption": self.textField.text!,
                "date": FieldValue.serverTimestamp()
            ] as [String : Any]
            postRef.setData(postDic)
            //HUDで投稿完了を表示
            SVProgressHUD.showSuccess(withStatus: "投稿しました")
            //投稿処理が完了したので先頭画面に戻る
            UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {//キャンセルButton
        self.dismiss(animated: true, completion: nil)//加工画面へ戻る
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image//受け取った画像をImageViewに設定する
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
