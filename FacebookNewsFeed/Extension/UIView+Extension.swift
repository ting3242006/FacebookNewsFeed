//
//  UIView+Extension.swift
//  FacebookNewsFeed
//
//  Created by Ting on 2023/8/16.
//

import Foundation
import UIKit

extension UIView {
    // the variable length of view which will come in as an array
    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, metrics: nil, views: viewDictionary))
    }
    /*
     這段程式碼是一個 UIView 的擴展（extension），它定義了一個名為 `addConstraintsWithFormat` 的自訂函式，用於在一個視圖中添加 Auto Layout 約束。這個函式的作用是簡化約束的設置過程，讓您可以使用一個格式字串來描述視圖之間的排列和大小關係。

     這個自訂函式具有以下特點：

     1. 函式名稱：`addConstraintsWithFormat(format:views:)`，表示這個函式是用來添加 Auto Layout 約束，並接受格式字串和視圖（可變數量）作為參數。

     2. 參數：
        - `format`：格式字串，用來描述視圖之間的排列和大小關係。這個格式字串可以類似 VFL（Visual Format Language）的語法，用來定義約束的配置。
        - `views`：可變數量的 UIView 物件，這些視圖是在約束中參與排列和大小的視圖。

     3. 函式實作：
        - 在函式內部，首先建立一個空的 `viewDictionary` 字典，用於存儲視圖和其對應的鍵（格式字串中使用的鍵）。
        - 使用 `enumerated` 方法遍歷傳遞的視圖陣列，獲取每個視圖和它在陣列中的索引。為每個視圖建立一個唯一的鍵（例如 "v0"、"v1"），並將視圖和鍵對應存儲到 `viewDictionary` 中。
        - 將每個視圖的 `translatesAutoresizingMaskIntoConstraints` 屬性設置為 `false`，以確保這些視圖使用 Auto Layout 進行排列。
        - 使用 `NSLayoutConstraint.constraints` 方法根據傳遞的格式字串和 `viewDictionary` 創建一組 Auto Layout 約束。
        - 最後，使用 `addConstraints` 方法將創建的約束添加到視圖上，從而實現了所描述的排列和大小設置。

     總之，這個自訂函式允許您以簡潔的方式使用格式字串來配置和排列視圖的約束，使 Auto Layout 的設置過程更加簡單和易讀。
     */
}
