/// Representa o horário de monitoria de um monitor.
class Schedule {
  /// Identificador único do horário de monitoria.
  final int id;

  /// Identificador do monitor associado a este horário.
  final String monitorId;

  /// Dia da semana em que a monitoria ocorre.
  final String dayOfWeek;

  /// Horário de início da monitoria.
  final String startTime;

  /// Horário de término da monitoria.
  final String endTime;

  /// Cria uma instância de [Schedule].
  Schedule({
    required this.id,
    required this.monitorId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });
}
