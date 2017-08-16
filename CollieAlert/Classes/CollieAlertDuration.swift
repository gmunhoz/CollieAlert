//
// Created by Guilherme Munhoz on 23/07/17.
//

import Foundation

public enum CollieAlertDuration {
    case short
    case medium
    case long
    case custom(seconds: Int)

    var durationInSeconds: Int {
        switch self {
        case .short:
            return 3
        case .medium:
            return 5
        case .long:
            return 10
        case .custom(let seconds):
            return seconds
        }
    }
}