import Foundation

func formatTimestamp(_ timestamp: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = dateFormatter.date(from: timestamp)
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    dateFormatter.locale = .current
    return dateFormatter.string(from: date!)
}
