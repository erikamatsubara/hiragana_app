//
//  RoundedTextView.swift
//  hiragana
//
//  Created by 松原えりか on 2019/08/09.
//  Copyright © 2019 松原えりか. All rights reserved.
//

import UIKit

/// 角丸テキストビュー.
class RoundedTextView: UITextView {
    /// 角丸にするフラグ.
    @IBInspectable var isRounded: Bool = false {
        didSet {
            if isRounded {
                layer.cornerRadius = UIScreen.main.bounds.width * 0.02
            }
        }
    }
    
    /// ボーダーの色.
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            if borderColor == .clear {
                return
            }
            layer.borderWidth = 1
            layer.borderColor = borderColor.cgColor
            let marginX = UIScreen.main.bounds.width * 0.02
            let marginY = UIScreen.main.bounds.width * 0.03
            textContainerInset = UIEdgeInsets(top: marginY, left: marginX, bottom: marginY, right: marginX)
        }
    }
    
    /// 画面横幅に対するフォントの大きさ（解像度対応のため）.
    @IBInspectable var fontSizePerScreenWidth: CGFloat = 0.05 {
        didSet {
            font = font?.withSize(UIScreen.main.bounds.width * fontSizePerScreenWidth)
        }
    }
}
