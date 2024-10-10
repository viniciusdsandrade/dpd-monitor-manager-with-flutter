class Schedule {
  final int id;
  final int monitorId;
  final String dayOfWeek;
  final String startTime;
  final String endTime;

  Schedule({
    required this.id,
    required this.monitorId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

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
