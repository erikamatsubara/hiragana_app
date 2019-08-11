//
//  ViewController.swift
//  hiragana
//
//  Created by 松原えりか on 2019/08/07.
//  Copyright © 2019 松原えりか. All rights reserved.
//

import UIKit

/// メイン画面コントローラ.
class ViewController: UIViewController {
    /// 入力欄.
    @IBOutlet weak var inputField: RoundedTextView!
    /// 出力欄.
    @IBOutlet weak var outputField: RoundedTextView!
    
    /// ひらがな化APIのURL.
    let apiURL = URL(string: R.string.conf.api_url())
    let api = HttpConnection<ResponseObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.config = self
        api.delegate = self
    }

    /// 実行ボタン押下時処理.
    @IBAction func onExecuteButtonTap(_ sender: Any) {
        // 入力文字列のバリデーション.
        if !checkInputText() {
            showConfirmAlert(
                title: R.string.ui.input_validation(),
                message: R.string.ui.input_letters()
            )
            return
        }
        
        guard let url = apiURL else {
            return
        }
        api.connect(url)
    }
    
    /// 入力欄に入力された文字列をチェックする.
    ///
    /// - Returns: 有効な文字列：true, 無効な文字列：false.
    private func checkInputText() -> Bool {
        guard let sentense = inputField.text, !sentense.isEmpty else {
            return false
        }
        return !sentense.trimmingCharacters(in: CharacterSet.letters.inverted).isEmpty
    }
}

extension ViewController: HttpConnectionDelegate {
    func onPreExecute(url: URL) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        showIndicator()
    }
    
    func onFailure(error: Error, retryCount: Int, retry: () -> Void) {
        // TODO: ステータスコードによってエラー処理を実装.
    }
    
    func onSuccess(response: Codable) {
        guard let res = response as? ResponseObject else {
            return
        }
        outputField.text = res.converted
    }
    
    func onPostExecute(url: URL) {
        hideIndicator()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}

extension ViewController: HttpConnectionConfig {
    var requestBody: Data? {
        get {
            guard let sentense = inputField.text else {
                return nil
            }
            let reqObj = RequestObject(sentence: sentense)
            return JsonUtility.toJson(obj: reqObj)
        }
    }
}
