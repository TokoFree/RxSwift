import Foundation

public struct RxCocoaLastClickDebugger {
    private static var className: String = ""

    public static var skipClassName: (() -> [String])?

    public static func getClassName() -> String {
        return Self.className
    }

    public static func setClassName(_ className: String) {
        // Reset State
        Self.className = ""
        Self.className = className
    }
    
    public static func appendClassName(_ className: String) {
        let appendText = "\(Self.className)-\(className)"
        Self.className = appendText
    }

    public static func findInherenceNode(in view: UIView) -> String? {
        guard let superview = view.superview, let skiplist = skipClassName?() else {
            return nil
        }

        let stringName = superview.description

        if !skiplist.contains(stringName) {
            return stringName
        }

        return findInherenceNode(in: superview)
    }
}
