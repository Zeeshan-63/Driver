
import UIKit

enum Strings: String {
    //MARK: - Properties Text
    
    //MARK: - Error Messages
    case implement_Later = "This feature will be implement later."
    case reached = "You reached at destination."
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: self.rawValue)
    }
}
