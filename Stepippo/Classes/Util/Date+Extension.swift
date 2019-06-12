import Foundation

extension Date {
    func toFormattedString(format: String = "yyyy年M月d日 HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
