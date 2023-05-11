import Foundation

class objcLogger: NSObject {
    @objc class func setLoggingLevelToDefault() {
        logger.setLoggingLevelToDefault()
    }

    @objc static func debug(_ message: String, file: String = #file, function: String = #function) {
        log(message: message, file: file, function: function, line: 0)
    }

    @objc static func log(message: String, file: String = #file, function: String = #function, line: Int = #line) {
        logger.consoleLogger.log(message: message, logLevel: LoggingLevel.debug, file: file, function: function, line: line)
      }
}
