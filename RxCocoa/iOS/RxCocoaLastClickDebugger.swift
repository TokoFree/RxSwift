import Foundation
import UIKit

public struct RxCocoaLastClickDebugger {
    public struct DebugData {
        public let className: String
        public let groupID: String
    }

    private static var debugData: DebugData?

    public static var skipClassName: (() -> [String])?

    /*
        Get the last clicked class name
    */
    public static func getDebugData() -> DebugData? {
        defer {
            Self.debugData = nil
        }
        return Self.debugData
    }

    /*
        Set the last clicked class name
    */
    public static func setClassName(_ className: String, groupID: String) {
        Self.debugData = DebugData(className: className, groupID: groupID)
    }

    /*
        Appending setted class name
    */
    public static func appendClassName(_ className: String) {
        let appendText = "\(Self.debugData?.className ?? "")-\(className)"
        let groupID = Self.debugData?.groupID ?? ""
        let newDebugData = DebugData(className: appendText, groupID: groupID)
        Self.debugData = newDebugData
    }

    /*
        This Function is used to recursively until get meaningfull class name
    */
    public static func findInherenceNode(in view: UIView, isGoingUp: Bool = true) -> String? {
        guard let skiplist = skipClassName?() else {
            return nil
        }

        let stringName = view.description

        if !skiplist.contains(where: { stringName.contains($0) }) {
            return stringName
        }

        if let superview = view.superview, isGoingUp {
            return findInherenceNode(in: superview)
        } else {
            for subview in view.subviews {
                if let found = findInherenceNode(in: subview, isGoingUp: false) {
                    return found.description
                }
            }
        }

        return nil
    }

}
