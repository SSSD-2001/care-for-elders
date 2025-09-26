import 'package:logging/logging.dart';

class AppLogger {
  static final Logger _logger = Logger('CareForElders');

  static void setupLogger() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      // Using developer.log instead of print for better performance
      // ignore: avoid_print
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  static void info(String message) {
    _logger.info(message);
  }

  static void debug(String message) {
    _logger.fine(message);
  }

  static void warning(String message) {
    _logger.warning(message);
  }

  static void error(String message, [Object? error]) {
    _logger.severe(message, error);
  }
}
