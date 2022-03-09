//
//  PostData.swift
//  Instagram
//  Created by jobs steve on 2022/02/06.
//

import UIKit
import Firebase

class PostData: NSObject {
    var id: String//投稿ID（保存する際に作られたユニークなID）
    var name: String?//投稿者名
    var caption: String?//キャプション
    var date: Date?//日付
    var likes: [String] = []//いいねをした人のIDの配列
    var isLiked: Bool = false//自分がいいねしたかどうかのフラグ//デフォルト有
    var comment: [String] = [] //2/23add：コメントの配列
    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        let postDic = document.data()
        self.name = postDic["name"] as? String
        self.caption = postDic["caption"] as? String
        if let comment = postDic["comment"] as? [String] {
            self.comment = comment
        }

        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
        
        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        if let myid = Auth.auth().currentUser?.uid {
            //likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil {
                //myidがあれば、いいねを押していると認識する。
                self.isLiked = true
            }
        }
    }
}
