//
//  HttpConnectionConfig.swift
//  hiragana
//
//  Created by 松原えりか on 2019/08/08.
//  Copyright © 2019 松原えりか. All rights reserved.
//

import Foundation

/// 通信の設定プロトコル.
protocol HttpConnectionConfig {
    /// ヘッダー.
    var header: [String: String]? { get }
    /// クエリパラメータ.
    var queryParameter: [String: String]? { get }
    /// リクエストボディ.
    var requestBody: Data? { get }
    /// リクエストのメソッド.
    var method: RequestMethod { get }
}

extension HttpConnectionConfig {
    var header: [String: String]? {
        get {
            return ["content-type": "application/json; charset=utf-8"]
        }
    }
    
    var queryParameter: [String: String]? {
        get {
            return nil
        }
    }
    
    var requestBody: Data? {
        get {
            return nil
        }
    }
    
    var method: RequestMethod {
        get {
            return .post
        }
    }
}
