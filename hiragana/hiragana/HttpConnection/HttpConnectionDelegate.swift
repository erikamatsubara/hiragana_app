//
//  HttpConnectionDelegate.swift
//  hiragana
//
//  Created by 松原えりか on 2019/08/07.
//  Copyright © 2019 松原えりか. All rights reserved.
//

import Foundation
import UIKit

/// HTTP通信デリゲートプロトコル.
protocol HttpConnectionDelegate {
    /// 通信実行前処理.
    /// デフォルトはログを吐くのみ.
    ///
    /// - Parameters:
    ///   - url: アクセスするURL.
    func onPreExecute(url: URL)
    
    /// 通信失敗時処理.
    /// デフォルトはエラー内容をログに吐き、3回までリトライ.
    ///
    /// - Parameters:
    ///   - error: エラーオブジェクト.
    ///   - retryCount: リトライ回数.
    ///   - retry: リトライ用デリゲート.
    func onFailure(error: Error, retryCount: Int, retry: () -> Void)
    
    /// 通信成功時処理.
    /// 必ず実装が必要.
    ///
    /// - Parameter response: オブジェクトに変換したレスポンス.
    func onSuccess(response: Codable)
    
    /// 通信実行後処理（失敗でも成功でも実行される）.
    /// デフォルトはログを吐くのみ.
    ///
    /// - Parameters:
    ///   - url: アクセスしたURL.
    func onPostExecute(url: URL)
}

extension HttpConnectionDelegate {
    func onPreExecute(url: URL) {
        print("Start----- URL: \(url.absoluteString)")
    }
    
    func onFailure(error: Error, retryCount: Int, retry: () -> Void) {
        print(error.localizedDescription)
        if retryCount >= 3 {
            return
        }
        retry()
    }
    
    func onPostExecute(url: URL) {
        print("End----- URL: \(url.absoluteString)")
    }
}
