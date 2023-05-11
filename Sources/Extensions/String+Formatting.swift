import Foundation

extension String {
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isEmptyWhenTrimmed: Bool {
        return trimmed.isEmpty
    }

    var convertedToNilIfEmpty: String? {
        if trimmed.isEmpty {
            return nil
        } else {
            return self.trimmed
        }
    }
    
    var firstLetterCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }

    func removeNewLines() -> String? {
        return self.replacingOccurrences(of: "\\n", with: "\n")
    }
 
}
