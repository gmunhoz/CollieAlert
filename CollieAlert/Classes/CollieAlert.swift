//
// Created by Guilherme Munhoz on 20/07/17.
//

import UIKit
import CoreGraphics

public class CollieAlert: UIView {

    public static var shared = CollieAlert()

    fileprivate let alertAnimationDuration = 0.3

    fileprivate var blurView: UIVisualEffectView!
    fileprivate var alertView: CollieAlertView!

    fileprivate var backgroundTapRecognizer: UITapGestureRecognizer!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupGestures()
        setupLayout()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupGestures()
        setupLayout()
    }

    public static func show(message: String, blurred: Bool = false) {
        shared.show(message: message, blurred: blurred)
    }

    public func show(message: String, blurred: Bool = false) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }

        self.frame = window.bounds
        self.alertView.load(message: message)

        if self.superview == nil {
            window.addSubview(self)
        }

        self.showAlertView(blurred: blurred)
    }

    public static func dismiss() {
        shared.dismiss()
    }

    public func dismiss() {
        self.hideAlertView()
    }

}

private extension CollieAlert {

    func setupViews() {
        setupBlurView()
        setupAlertView()
    }

    func setupBlurView() {
        let blurEffect = UIBlurEffect(style: .light)

        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.alpha = 0.0

        addSubview(blurView)
    }

    func setupAlertView() {
        alertView = CollieAlertView()
        alertView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(alertView)
    }

    func setupGestures() {
        backgroundTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        self.addGestureRecognizer(backgroundTapRecognizer)
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

        constraints.append(NSLayoutConstraint(item: blurView,
                attribute: .height, relatedBy: .equal, toItem: self,
                attribute: .height, multiplier: 1, constant: 0))

        constraints.append(NSLayoutConstraint(item: blurView,
                attribute: .width, relatedBy: .equal, toItem: self,
                attribute: .width, multiplier: 1, constant: 0))

        NSLayoutConstraint.activate(constraints)
    }

    func showAlertView(blurred: Bool = false) {
        let alertSize = alertView.calculateEstimatedSize()
        self.alertView.transform = CGAffineTransform(translationX: 0.0, y: -(alertSize.height * 2.0))
        self.blurView.alpha = 0.0

        let animations = {
            if blurred {
                self.blurView.alpha = 1.0
            }
            self.alertView.transform = CGAffineTransform.identity
        }

        UIView.animate(withDuration: alertAnimationDuration, animations: animations) { _ in
            self.backgroundTapRecognizer.isEnabled = true
        }
    }

    func hideAlertView() {
        let alertSize = alertView.calculateEstimatedSize()

        let animations = {
            self.blurView.alpha = 0.0
            self.alertView.transform = CGAffineTransform(translationX: 0.0, y: -(alertSize.height * 2.0))
        }

        UIView.animate(withDuration: alertAnimationDuration, animations: animations) { _ in
            self.backgroundTapRecognizer.isEnabled = false
            self.removeFromSuperview()
        }

    }

}
