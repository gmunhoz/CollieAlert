//
// Created by Guilherme Munhoz on 20/07/17.
//

import UIKit

protocol CollieAlertViewDelegate {
    func shouldDismiss()
    func changedPosition(offset: CGFloat)
}

class CollieAlertView: UIView {

    fileprivate let topMargin: CGFloat = 36.0
    fileprivate let defaultMargin: CGFloat = 16.0

    fileprivate var messageLabel: UILabel!

    var delegate: CollieAlertViewDelegate?

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

    func load(message: String) {
        messageLabel.text = message
    }

    func calculateEstimatedSize() -> CGSize {
        let maxSize = CGSize(width: self.bounds.size.width, height: CGFloat.greatestFiniteMagnitude)
        let estimatedHeight = topMargin + messageLabel.sizeThatFits(maxSize).height + defaultMargin
        return CGSize(width: maxSize.width, height: estimatedHeight)
    }

//    fileprivate var startPoint: CGPoint?
//    fileprivate var lastOffset: CGFloat = 0.0
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//
//        if let touch = touches.first {
//            startPoint = touch.location(in: self.superview)
//            print("Touches began at: \(startPoint!)")
//        }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesMoved(touches, with: event)
//
//        if let touch = touches.first, let startPoint = self.startPoint {
//            let currentPoint = touch.location(in: self.superview)
//
//            let distance = min(currentPoint.y - startPoint.y, 0.0)
//            let offset = abs(distance) / self.bounds.size.height
//            print("Distance: \(distance) | Offset: \(offset)")
//
//            self.transform = CGAffineTransform(translationX: 0.0, y: distance)
//
//            if lastOffset != offset {
//                self.delegate?.changedPosition(offset: offset)
//            }
//
//            lastOffset = offset
//        }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesEnded(touches, with: event)
//
//        if let touch = touches.first, let startPoint = self.startPoint {
//            let endPoint = touch.location(in: self.superview)
//            print("Touches ended at: \(endPoint)")
//
//            let distance = min(endPoint.y - startPoint.y, 0.0)
//            print("Final distance: \(distance)")
//
//            let size = calculateEstimatedSize()
//
//            if -distance >= (size.height / 2.0) {
//                let animations = {
//                    self.transform = CGAffineTransform(translationX: 0.0, y: -(size.height * 2.0))
//                }
//
//                UIView.animate(withDuration: 0.3, animations: animations) { _ in
//                    self.delegate?.shouldDismiss()
//                }
//
//            } else {
//                UIView.animate(withDuration: 0.3) {
//                    self.transform = CGAffineTransform.identity
//                }
//
//            }
//
//        }
//
//        startPoint = nil
//    }


}

private extension CollieAlertView {

    func setupViews() {
        self.backgroundColor = .white
        self.clipsToBounds = false

        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowRadius = 5.0

        setupMessageLabel()
    }

    func setupMessageLabel() {
        messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0

        addSubview(messageLabel)
    }

    func setupLayout() {
        var constraints = [NSLayoutConstraint]()

        let views: [String: Any] = [
            "messageLabel": messageLabel
        ]

        let metrics: [String: Any] = [
            "topMargin": topMargin,
            "margin": defaultMargin
        ]

        constraints += NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-margin-[messageLabel]-margin-|",
                metrics: metrics,
                views: views)

        constraints += NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-topMargin-[messageLabel]-margin-|",
                metrics: metrics,
                views: views)

        constraints.append(NSLayoutConstraint(item: messageLabel,
                attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil,
                attribute: .notAnAttribute, multiplier: 1, constant: 0))

        NSLayoutConstraint.activate(constraints)
    }

}
