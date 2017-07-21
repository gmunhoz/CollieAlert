//
// Created by Guilherme Munhoz on 20/07/17.
//

import UIKit

class CollieAlertView: UIView {

    fileprivate let topMargin: CGFloat = 36.0
    fileprivate let defaultMargin: CGFloat = 16.0

    fileprivate var messageLabel: UILabel!

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
