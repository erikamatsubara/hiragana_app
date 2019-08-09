//
//  UIViewControllerExtension.swift
//  hiragana
//
//  Created by 松原えりか on 2019/08/08.
//  Copyright © 2019 松原えりか. All rights reserved.
//

import UIKit

extension UIViewController {
    /// ローディングインジケータ.
    private static let indicator = UIActivityIndicatorView()
    
    /// インジケータ表示.
    func showIndicator() {
        if !view.subviews.contains(UIViewController.indicator) {
            // インジケータの設定.
            UIViewController.indicator.style = .gray
            UIViewController.indicator.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
            UIViewController.indicator.hidesWhenStopped = true
            
            // 画面に追加.
            if !(view is UIVisualEffectView) {
                view.addSubview(UIViewController.indicator)
            }
        }
        
        // 最前面に移動.
        view.bringSubviewToFront(UIViewController.indicator)
        
        // アニメーション開始.
        UIViewController.indicator.startAnimating()
        // タップイベントを無効にする.
        if !UIApplication.shared.isIgnoringInteractionEvents {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    /// インジケータを非表示にする.
    func hideIndicator() {
        // アニメーション終了（自動非表示）.
        UIViewController.indicator.stopAnimating()
        // タップイベントを有効にする.
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    
    /// OKボタンのみのアラートを表示する.
    ///
    /// - Parameters:
    ///   - title: ダイアログタイトル.
    ///   - message: メッセージ.
    ///   - onButtonTap: OKボタン押下時処理.
    func showConfirmAlert(title: String, message: String, onButtonTap: (() -> Void)? = nil) {
        // アラートを作成.
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // アラートにボタンをつける.
        if let callback = onButtonTap {
            alert.addAction(UIAlertAction(title: R.string.ui.btn_ok(), style: .default, handler: { _ in
                callback()
                }))
        } else {
            alert.addAction(UIAlertAction(title: R.string.ui.btn_ok(), style: .default))
        }
        
        // アラート表示.
        present(alert, animated: true, completion: nil)
    }
}
