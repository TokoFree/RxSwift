import Foundation

public struct RxCocoaLastClickDebugger {
    public static var getClassName: ((String?) -> Void)?

    private static var className: String = ""

    public static func setClassName(_ className: String) {
        // Reset State
        Self.className = ""
        Self.getClassName?(className)
        Self.className = className
    }

    public static func appendClassName(_ className: String) {
        let appendText = "\(Self.className)-\(className)"
        Self.getClassName?(appendText)
        Self.className = appendText
    }

    public static func findInherenceNode(in view: UIView) -> String? {
        guard let superview = view.superview else {
            return nil
        }

        let stringName = superview.description

        if !stringName
            .contains(
                "UIView"
            ),
            !stringName
                .contains(
                    "CollectionViewCell"
                ),
            !stringName
                .contains(
                    "CollectionView"
                ),
            !stringName
                .contains(
                    "SharedUI"
                ),
            !stringName
                .contains(
                    "iCarousel"
                ),
            !stringName
                .contains(
                    "ScrollView"
                )
        {
            return stringName
        }

        return findInherenceNode(in: superview)
    }
}
