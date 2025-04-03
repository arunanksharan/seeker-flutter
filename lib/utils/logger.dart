import 'package:logger/logger.dart';

// Configure the logger
final appLogger = Logger(
  printer: PrettyPrinter(
    methodCount: 0, // number of method calls to be displayed
    errorMethodCount: 5, // number of method calls if stacktrace is provided
    lineLength: 80, // width of the output
    colors: true, // Colorful log messages
    printEmojis: true, // Print an emoji for each log message
    printTime: true, // Should each log print contain a timestamp
  ),
  // You can set the minimum level for logs to be shown
  // level: Level.debug, // Default: Level.verbose
);

// Setup logger function
void setupLogger() {
  appLogger.i('Logger initialized');
}

// Convenience functions (optional, but can be nice)
void logDebug(String message, [dynamic error, StackTrace? stackTrace]) {
  appLogger.d(message, error: error, stackTrace: stackTrace);
}

void logInfo(String message, [dynamic error, StackTrace? stackTrace]) {
  appLogger.i(message, error: error, stackTrace: stackTrace);
}

void logWarning(String message, [dynamic error, StackTrace? stackTrace]) {
  appLogger.w(message, error: error, stackTrace: stackTrace);
}

void logError(String message, [dynamic error, StackTrace? stackTrace]) {
  appLogger.e(message, error: error, stackTrace: stackTrace);
}

void logWtf(String message, [dynamic error, StackTrace? stackTrace]) {
  appLogger.wtf(message, error: error, stackTrace: stackTrace);
}
