import Foundation

struct Find: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date = Date()
    var location: String
    var points: String
    var size: String
}
