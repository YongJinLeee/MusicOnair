//
//  DefaultStyle.swift
//  MusicOnair
//
//  Created by LeeYongJin
//

import UIKit

public enum DefaultStyle {
    public enum Colors {
        public static let tint: UIColor = {
            if #available(iOS 14.0, *) {
                return UIColor { traitCollection in
                    if traitCollection.userInterfaceStyle == .dark {
                        return .white
                    } else {
                        return .black
                    }
                }
            } else {
                return .black
            }
        }()
    }
}

