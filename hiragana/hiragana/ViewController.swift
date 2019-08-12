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
    /// 通信処理クラス.
    let api = HttpConnection<ResponseObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.config = self
        api.delegate = self
        let hideTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardTap))
        view.addGestureRecognizer(hideTap)
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
    
    /// キーボード外タップ時処理.
    @objc private func hideKeyboardTap() {
        inputField.endEditing(true)
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
    /// 最大リトライ回数.
    private static let MAX_RETRY_COUNT = 3
    
    func onPreExecute(url: URL) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        showIndicator()
    }
    
    func onFailure(error: Error, retryCount: Int, retry: @escaping () -> Void) {
        print(error.localizedDescription)
        
        let e = error as NSError
        let isRetry = retryCount < ViewController.MAX_RETRY_COUNT && checkNeedRetry(e)
        
        if isRetry {
            // リトライ条件に一致する場合はリトライ確認ダイアログを表示する.
            showConfirmAlert(
                title: R.string.ui.connection_failure(),
                message: R.string.ui.retry_confirm(),
                onButtonTap: retry
            )
            return
        }
        // リトライの上限回数を超えた場合は時間を空けるよう促す.
        showConfirmAlert(
            title: R.string.ui.connection_failure(),
            message: R.string.ui.take_time()
        )
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
    
    /// リトライする意味があるか判断する.
    ///
    /// - Parameter e: 通信中に発生したエラー.
    /// - Returns: リトライする意味あり：true, リトライする意味なし：false.
    private func checkNeedRetry (_ e: NSError) -> Bool {
        switch e.code {
        case NSURLErrorNetworkConnectionLost:
            return true
        case NSURLErrorNotConnectedToInternet:
            return true
        case HttpStatusCode.internalServerError.rawValue:
            return true
        default:
            return false
        }
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
