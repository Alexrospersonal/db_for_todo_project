import 'package:logger/web.dart';

class LogService {
  static final Logger _logger = Logger(printer: PrettyPrinter());

  static Logger get logger => _logger;
}
