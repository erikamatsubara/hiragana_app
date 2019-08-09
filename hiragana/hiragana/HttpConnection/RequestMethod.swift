//
//  RequestMethod.swift
//  hiragana
//
//  Created by 松原えりか on 2019/08/08.
//  Copyright © 2019 松原えりか. All rights reserved.
//

/// リクエストメソッドの種類.
enum RequestMethod: String {
    case post   = "POST"
    case get    = "GET"
    case put    = "PUT"
    case delete = "DELETE"
    case patch  = "PATCH"
}
