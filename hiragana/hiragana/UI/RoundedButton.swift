//
//  RoundedButton.swift
//  hiragana
//
//  Created by 松原えりか on 2019/08/09.
//  Copyright © 2019 松原えりか. All rights reserved.
//

import UIKit

/// 角丸ボタン.
class RoundedButton: UIButton {
    /// 角丸にするフラグ.
    @IBInspectable var isRounded: Bool = false {
        didSet {
            if isRounded {
                layer.cornerRadius = UIScreen.main.bounds.width * 0.02
            }
        }
    }
    
    /// 画面横幅に対するフォントの大きさ（解像度対応のため）.
    @IBInspectable var fontSizePerScreenWidth: CGFloat = 0.05 {
        didSet {
            titleLabel?.font = titleLabel?.font.withSize(UIScreen.main.bounds.width * fontSizePerScreenWidth)
        }
    }
}
