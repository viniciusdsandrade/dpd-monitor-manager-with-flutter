/// Representa o horário de monitoria de um monitor do DPD.
///
/// A classe [Schedule] contém informações sobre quando um monitor está disponível
/// para atender aos alunos durante a semana.
class Schedule {
  /// Identificador único do horário de monitoria.
  final int id;

  /// Identificador do monitor associado a este horário.
  ///
  /// Relaciona o horário ao monitor correspondente na classe [Monitor].
  final int monitorId;

  /// Dia da semana em que a monitoria ocorre.
  ///
  /// Exemplo: 'Segunda-feira', 'Terça-feira', etc.
  final String dayOfWeek;

  /// Horário de início da monitoria.
  ///
  /// Formato esperado: 'HH:MM', por exemplo, '14:00'.
  final String startTime;

  /// Horário de término da monitoria.
  ///
  /// Formato esperado: 'HH:MM', por exemplo, '16:00'.
  final String endTime;

  /// Cria uma instância de [Schedule].
  ///
  /// Todas as propriedades são obrigatórias.
  ///
  /// ```dart
  /// Schedule schedule = Schedule(
  ///   id: 1,
  ///   monitorId: 1,
  ///   dayOfWeek: 'Segunda-feira',
  ///   startTime: '14:00',
  ///   endTime: '16:00',
  /// );
  /// ```
  Schedule({
    required this.id,
    required this.monitorId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  /// Cria uma instância de [Schedule] a partir de um mapa JSON.
  ///
  /// Este metodo é útil para converter dados recebidos de uma API em um objeto [Schedule].
  ///
  /// ```dart
  /// Map<String, dynamic> json = {
  ///   'id': 1,
  ///   'monitorId': 1,
  ///   'dayOfWeek': 'Segunda-feira',
  ///   'startTime': '14:00',
  ///   'endTime': '16:00',
  /// };
  /// Schedule schedule = Schedule.fromJson(json);
  /// ```
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      monitorId: json['monitorId'],
      dayOfWeek: json['dayOfWeek'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }
}
