//
//  BookSearchTableViewController.swift
//  ExtentionBooksApp
//
//  Created by Rentaro on 2020/04/05.
//  Copyright © 2020 Rentaro. All rights reserved.
//

import UIKit
import Moya

class BookSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var booksDataArray = [VolumeInfo]()
    
    var imageCache = NSCache<AnyObject, UIImage>()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //入力文字があるかどうかチェック！
        guard let inputText = searchBar.text else {
            //入力文字がない場合はリターン
            return
        }
        
        //入力文字が0文字より多いかどうかチェック
        guard inputText.lengthOfBytes(using: String.Encoding.utf8) > 0 else {
            //0文字より多くなかった場合
            return
        }
        
        //保持している商品を一旦全削除
        booksDataArray.removeAll()
        
        let provider = MoyaProvider<GoogleBooksApi>()
        provider.request(.search(request: ["q": "\(inputText)", "maxResults": "12"])) { result in
            switch result {
            case let .success(moyaResponse):
                let jsonData = try? JSONDecoder().decode(ResultJson.self, from: moyaResponse.data)
                dump(jsonData!)
                
                // オブジェクトの存在を確認して、商品のリストに追加
                for count in 0...11 {
                    if jsonData!.items[count].volumeInfo != nil {
                    self.booksDataArray.append(jsonData!.items[count].volumeInfo!)
                    } else {
                        break
                    }
                }
                
            case let .failure(error):
                print("アクセスに失敗しました:\(error)")
            }
            
            DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                //キーボードを閉じる
                searchBar.resignFirstResponder()
                
            }
            
            
        }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return booksDataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! ItemTableViewCell
        
        let bookData = booksDataArray[indexPath.row]

        //本のタイトル設定
        cell.bookTitleLabel.text = bookData.title
        if bookData.authors != nil {
            //作者がいる場合の処理
            let hitAuthors = bookData.authors?.joined(separator: ",")
            cell.bookAuthorsLabel.text = hitAuthors
        } else {
            //作者がいなかった場合
            cell.bookAuthorsLabel.text = "作者なし"
        }
        
        guard let bookImageUrl = bookData.imageLinks?.smallThumbnail else {
            //画像なし
            return cell
        }
        
        //キャッシュの画像取り出し
        if let cacheImage = imageCache.object(forKey: bookImageUrl as AnyObject) {
            //キャッシュ画像設定
            cell.bookImage.image = cacheImage
            return cell
        }
        
        //キャッシュの画像がないときのダウンロード
        guard let url = URL(string: bookImageUrl) else {
            //url生成できんかった
            return cell
        }
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) {(data:Data?, response:URLResponse?, error:Error?) in
            guard error == nil else {
                //エラーあり
                return
            }
            
            guard let data = data else {
                //データがない
                return
            }
            
            guard let image = UIImage(data: data) else {
                //imageが生成できなかった
                return
            }
            
            //ダウンロードした画像をキャッシュに登録する処理
            self.imageCache.setObject(image, forKey: bookImageUrl as AnyObject)
            //画像に関する処理をメインスレッドで設定
            DispatchQueue.main.async {
                cell.bookImage.image = image
            }
        }
        
        task.resume()
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
