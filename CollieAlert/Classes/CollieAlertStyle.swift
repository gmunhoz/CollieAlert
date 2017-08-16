//
// Created by Guilherme Munhoz on 15/08/17.
//

import UIKit
import CoreGraphics

public enum CollieAlertStyle {
    case normal
    case blurred(style: UIBlurEffectStyle)

    var backgroundView: UIView {
        switch self {
            case let .blurred(style):
                let blurEffect = UIBlurEffect(style: style)
                return UIVisualEffectView(effect: blurEffect)
            default:
                let backgroundView = UIView()
                backgroundView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
                return backgroundView
        }
    }
}