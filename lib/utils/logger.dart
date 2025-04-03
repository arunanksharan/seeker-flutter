import 'package:logger/logger.dart';

// Configure the logger
final appLogger = Logger(
  printer: PrettyPrinter(
    methodCount: 1, // number of method calls to be displayed
    errorMethodCount: 8, // number of method calls if stacktrace is provided
    lineLength: 120, // width of the output
    colors: true, // Colorful log messages
    printEmojis: true, // Print an emoji for each log message
    printTime: false, // Should each log print contain a timestamp
  ),
  // You can set the minimum level for logs to be shown
  // level: Level.debug, // Default: Level.verbose
);

// Convenience functions (optional, but can be nice)
void logVerbose(dynamic message, [dynamic error, StackTrace? stackTrace]) {
  appLogger.t(message, error: error, stackTrace: stackTrace);
}

void logDebug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
  appLogger.d(message, error: error, stackTrace: stackTrace);
}

void logInfo(dynamic message, [dynamic error, StackTrace? stackTrace]) {
  appLogger.i(message, error: error, stackTrace: stackTrace);
}

void logWarning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
  appLogger.w(message, error: error, stackTrace: stackTrace);
}

void logError(dynamic message, [dynamic error, StackTrace? stackTrace]) {
  appLogger.e(message, error: error, stackTrace: stackTrace);
}

void logFatal(dynamic message, [dynamic error, StackTrace? stackTrace]) {
  appLogger.f(message, error: error, stackTrace: stackTrace);
}
