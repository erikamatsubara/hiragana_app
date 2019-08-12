//
//  RequestObject.swift
//  hiragana
//
//  Created by 松原えりか on 2019/08/09.
//  Copyright © 2019 松原えりか. All rights reserved.
//

/// APIへのリクエスト変換用オブジェクト.
struct RequestObject: Codable {
    let app_id = R.string.conf.app_id()
    let output_type = R.string.conf.output_type()
    
    var sentence: String
}
