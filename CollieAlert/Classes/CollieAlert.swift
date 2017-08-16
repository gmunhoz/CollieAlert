//
// Created by Guilherme Munhoz on 20/07/17.
//

import UIKit
import CoreGraphics

public class CollieAlert: UIView {

    public static var shared = CollieAlert()

    fileprivate let animationDuration = 0.3

    fileprivate var startPoint: CGPoint?
    fileprivate var lastOffset: CGFloat = 0.0

    fileprivate var backgroundView: UIView!
    fileprivate var alertView: CollieAlertView!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupLayout()
    }

    public static func show(message: String,
                            duration: CollieAlertDuration = .medium,
                            style: CollieAlertStyle = .normal) {
        shared.show(message: message, duration: duration, style: style)
    }

    public func show(message: String,
                     duration: CollieAlertDuration = .medium,
                     style: CollieAlertStyle = .normal) {

        guard let window = UIApplication.shared.keyWindow else {
            return
        }

        self.frame = window.bounds
        self.alertView.load(message: message)
        self.setupBackgroundView(style: style)

        if self.superview == nil {
            window.addSubview(self)
        }

        self.showAlertView(resetPosition: true)
    }

    public static func dismiss() {
        shared.dismiss()
    }

    public func dismiss() {
        self.hideAlertView()
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        if let touch = touches.first, let touchView = touch.view, touchView == alertView {
            startPoint = touch.location(in: self)
        }
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)

        if let touch = touches.first, let startPoint = self.startPoint {
            let currentPoint = touch.location(in: self)
            let distance = min(currentPoint.y - startPoint.y, 0.0)
            let offset = abs(distance) / alertView.bounds.size.height

            alertView.transform = CGAffineTransform(translationX: 0.0, y: distance)

            if lastOffset != offset {
                backgroundView?.alpha = 1.0 - offset
            }

            lastOffset = offset
        }
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        if let touch = touches.first, let startPoint = self.startPoint {
            let endPoint = touch.location(in: self)
            let distance = max(abs(startPoint.y - endPoint.y), 0.0)
            let alertHeight = alertView.bounds.size.height

            if distance >= (alertHeight / 3.0) {
                hideAlertView()

            } else {
                showAlertView()

            }

        }

        startPoint = nil
        lastOffset = 0.0
    }

}

private extension CollieAlert {

    func setupViews() {
        setupAlertView()
    }

    func setupBackgroundView(style: CollieAlertStyle) {
        if backgroundView != nil && backgroundView.superview != nil {
            backgroundView.removeFromSuperview()
        }

        backgroundView = style.backgroundView
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.alpha = 0.0

        insertSubview(backgroundView, belowSubview: alertView)

        setupBackgroundConstraints()
    }

    func setupAlertView() {
        alertView = CollieAlertView()
        alertView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(alertView)
    }

    func setupLayout() {
        var constraints = [NSLayoutConstraint]()

        let views: [String: Any] = [
                "alertView": alertView
        ]

        constraints += NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[alertView]-0-|",
                metrics: nil,
                views: views)

        constraints += NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-0-[alertView(>=0)]",
                metrics: nil,
                views: views)

        NSLayoutConstraint.activate(constraints)
    }

    func setupBackgroundConstraints() {
        var constraints = [NSLayoutConstraint]()

        constraints.append(NSLayoutConstraint(item: backgroundView,
                attribute: .height, relatedBy: .equal, toItem: self,
                attribute: .height, multiplier: 1, constant: 0))

        constraints.append(NSLayoutConstraint(item: backgroundView,
                attribute: .width, relatedBy: .equal, toItem: self,
                attribute: .width, multiplier: 1, constant: 0))

        NSLayoutConstraint.activate(constraints)
    }

    func showAlertView(resetPosition: Bool = false) {
        let alertSize = alertView.calculateEstimatedSize()

        if resetPosition {
            alertView.transform = CGAffineTransform(translationX: 0.0, y: -(alertSize.height * 2.0))
            backgroundView?.alpha = 0.0
        }

        UIView.animate(withDuration: animationDuration) {
            self.alertView.transform = CGAffineTransform.identity
            self.backgroundView?.alpha = 1.0
        }
    }

    func hideAlertView() {
        let alertSize = alertView.calculateEstimatedSize()

        let animations = {
            self.backgroundView?.alpha = 0.0
            self.alertView.transform = CGAffineTransform(translationX: 0.0, y: -(alertSize.height * 2.0))
        }

        UIView.animate(withDuration: animationDuration, animations: animations) { _ in
            self.removeFromSuperview()
        }

    }

}
