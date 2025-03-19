import Foundation
import UIKit

public struct RxCocoaLastClickDebugger {
    private static var className: String = ""

    public static var skipClassName: (() -> [String])?

    /*
        Get the last clicked class name
    */
    public static func getClassName() -> String {
        return Self.className
    }

    /*
        Set the last clicked class name
    */
    public static func setClassName(_ className: String) {
        // Reset State
        Self.className = ""
        Self.className = className
    }

    /*
        Appending setted class name
    */
    public static func appendClassName(_ className: String) {
        let appendText = "\(Self.className)-\(className)"
        Self.className = appendText
    }

    /*
        This Function is used to recursively until get meaningfull class name
    */
    public static func findInherenceNode(in view: UIView) -> String? {
        guard let superview = view.superview, let skiplist = skipClassName?() else {
            return nil
        }

        let stringName = superview.description

        let skipCheck = skiplist.map {
            return !stringName.contains($0)
        }.filter { $0 }

        if skipCheck.count == skiplist.count {
            return stringName
        }

        return findInherenceNode(in: superview)
    }
}
