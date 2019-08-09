//
//  HttpConnection.swift
//  hiragana
//
//  Created by 松原えりか on 2019/08/07.
//  Copyright © 2019 松原えりか. All rights reserved.
//

import UIKit

/// HTTP通信クラス.
class HttpConnection<T: Codable> {
    var url: URL!
    var delegate: HttpConnectionDelegate?
    var config: HttpConnectionConfig?
    var timeoutInterval = 8.0
    private var retryCount = 0
    
    /// 接続する.
    ///
    /// - Parameter u: 接続するAPIのURL.
    func connect(_ u: URL) {
        url = u
        
        // queryString情報をconfigから取得して追加.
        if let queryParameter = config?.queryParameter, retryCount == 0 {
             url = URL(string: url.absoluteString + getQueryString(params: queryParameter))
        }
        
        if let delegate = delegate {
            // 接続前処理を実行.
            delegate.onPreExecute(url: url)
        }
        
        // リクエストを作成.
        var request = URLRequest(url: url)
        
        request.timeoutInterval = timeoutInterval
        request.httpMethod = config?.method.rawValue
        
        // ヘッダー情報をconfigから取得して追加.
        if let headers = config?.header {
            for header in headers {
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        // requestBody情報をconfigから取得して追加.
        if let requestBody = config?.requestBody {
            request.httpBody = requestBody
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: handleResult)
        
        task.resume()
        
        // 通信後処理.
        if let delegate = delegate {
            delegate.onPostExecute(url: url)
        }
    }
    
    /// 通信をリトライする.
    private func retry() {
        retryCount += 1
        connect(url)
    }
    
    /// 通信結果のハンドリング.
    private func handleResult(apiData: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            // 失敗通知.
            DispatchQueue.main.async {
                // ネットワークに接続していない等のクライアント側エラー.
                if let delegate = self.delegate {
                    delegate.onFailure(error: error, retryCount: self.retryCount, retry: self.retry)
                }
            }
            return
        }
        
        guard let apiData = apiData, let response = response as? HTTPURLResponse else {
            // 失敗通知.
            DispatchQueue.main.async {
                // レスポンスなし.
                if let delegate = self.delegate {
                    delegate.onFailure(error: URLError(.badServerResponse), retryCount: self.retryCount, retry: self.retry)
                }
            }
            return
        }
        
        if response.statusCode != HttpStatusCode.ok.rawValue {
            // 失敗通知.
            DispatchQueue.main.async {
                // サーバ側エラー.
                if let delegate = self.delegate {
                    delegate.onFailure(error: URLError(URLError.Code(rawValue: response.statusCode)), retryCount: self.retryCount, retry: self.retry)
                }
            }
            return
        }
        
        let jsonStr: String = String(data: apiData, encoding: .utf8)!
        
        guard let data: T = JsonUtility.toObj(jsonStr: jsonStr) else {
            DispatchQueue.main.async {
                // 変換エラー(レスポンスの型違い).
                if let delegate = self.delegate {
                    delegate.onFailure(error: URLError(.cannotDecodeContentData), retryCount: self.retryCount, retry: self.retry)
                }
            }
            return
        }
        
        // 通常終了.
        DispatchQueue.main.async {
            if let delegate = self.delegate {
                // 成功時デリゲートを実行.
                delegate.onSuccess(response: data)
            }
        }
    }
    
    /// クエリ文字列を作成する.
    ///
    /// - Parameter params: クエリ文字列に変換したいパラメータ.
    private func getQueryString(params: [String: String]) -> String {
        if params.count == 0 {
            return ""
        }
        var queryString = "?"
        var counter: Int = 0
        for (key, value) in params {
            queryString.append(key)
            queryString.append("=")
            queryString.append(value)
            if counter < params.count - 1 {
                // 要素が続く場合は&をつける
                queryString.append("&")
            }
            counter += 1
        }
        return queryString
    }
}
