// lib/utils/logger.dart
import 'package:logging/logging.dart';

final Logger logger = Logger('DPDMonitorManager');

void setupLogger() {
  Logger.root.level = Level.ALL; // Defina o nível de log desejado
  Logger.root.onRecord.listen((record) {
    // Customize a forma como os logs são exibidos
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}
