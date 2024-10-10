import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/monitor.dart';
import '../models/schedule.dart';

class MonitorDetailScreen extends StatefulWidget {
  final Monitor monitor;

  const MonitorDetailScreen({super.key, required this.monitor});

  @override
  MonitorDetailScreenState createState() => MonitorDetailScreenState();
}

class MonitorDetailScreenState extends State<MonitorDetailScreen> {
  late Future<List<Schedule>> futureSchedules;

  @override
  void initState() {
    super.initState();
    futureSchedules = ApiService.fetchSchedules(widget.monitor.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.monitor.name),
      ),
      body: FutureBuilder<List<Schedule>>(
        future: futureSchedules,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Schedule> schedules = snapshot.data!;
            return ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                Schedule schedule = schedules[index];
                return ListTile(
                  title: Text(
                    '${schedule.dayOfWeek}: ${schedule.startTime} - ${schedule.endTime}',
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
