//
//  JsonUtility.swift
//  hiragana
//
//  Created by 松原えりか on 2019/08/07.
//  Copyright © 2019 松原えりか. All rights reserved.
//

import Foundation

/// Jsonを操作するユーティリティクラス.
class JsonUtility {
    
    /// Json文字列から構造体に変換する.
    /// 失敗するとnilを返す.
    ///
    /// - Parameter jsonStr: Json文字列.
    /// - Returns: Jsonを変換したオブジェクト.
    static func toObj<T: Codable>(jsonStr: String) -> T? {
        // 文字列を目的のオブジェクト型に変換.
        let decoder = JSONDecoder()
        guard let data = try? decoder.decode(T?.self, from: jsonStr.data(using: .utf8)!) else {
            return nil
        }
        
        return data
    }
    
    /// 構造体からJsonに変換する.
    /// 失敗するとnilを返す.
    ///
    /// - Parameter data: 構造体のオブジェクト.
    /// - Returns: オブジェクトを変換したJson.
    static func toJson<T: Codable>(obj: T) -> Data? {
        let encoder = JSONEncoder()
        guard let json = try? encoder.encode(obj) else {
            return nil
        }
        
        return json
    }
}
