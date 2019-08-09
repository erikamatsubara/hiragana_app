//
//  AsyncLoadImageView.swift
//  hiragana
//
//  Created by 松原えりか on 2019/08/09.
//  Copyright © 2019 松原えりか. All rights reserved.
//

import UIKit

/// 非同期ロード画像ビュー.
class AsyncLoadImageView: UIImageView {
    /// ロードする画像のURL.
    @IBInspectable var loadURL: String = "" {
        didSet {
            guard let url = URL(string: loadURL), UIApplication.shared.canOpenURL(url) else {
                return
            }
            DispatchQueue.global(qos: .default).async {
                let imageData = try? Data(contentsOf: url, options: NSData.ReadingOptions.mappedIfSafe)
                guard let data = imageData else {
                    return
                }
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    // ロードが完了したら表示させる.
                    self.image = image
                }
            }
        }
    }
}
