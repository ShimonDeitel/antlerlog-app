import SwiftUI

enum Theme {
    static let background = Color(red: 0.118, green: 0.090, blue: 0.071)
    static let accent = Color(red: 0.545, green: 0.369, blue: 0.204)
    static let accent2 = Color(red: 0.369, green: 0.478, blue: 0.294)
    static let cardBackground = Color(.secondarySystemGroupedBackground)

    static let titleFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)
}
