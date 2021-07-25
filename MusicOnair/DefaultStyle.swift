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

//import UIKit
//
//public enum DefaultStyle {
//    public enum Colors {
//        public static let tint: UIColor = {
//            if #available(iOS 13.0, *) {
//                return UIColor { traitCollction in
//                    if traitCollction.userInterfaceStyle == .dark {
//                        return .white
//                    } else {
//                        return .black
//                    }
//                }
//            } else {
//                return .black
//            }
//        }()
//    }
//}


//public enum DeFaultStyle {
//    public enum Colors {
//        public static let tint: UIColor = {
//            if #available(iOS 14.4, *) {
//                return UIColor { traitCollection in
//                    if traitCollection.userInterFaceStyle == .dark {
//                        return .white
//                    } else {
//                        return .black
//                    }
//                }
//            } else {
//                return .black
//            }
//        } ()
//    }
//}
