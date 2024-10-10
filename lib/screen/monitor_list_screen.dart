import 'package:flutter/material.dart';
import '../models/monitor.dart';
import '../services/api_service.dart';
import 'monitor_detail_screen.dart';

class MonitorListScreen extends StatefulWidget {
  const MonitorListScreen({super.key});

  @override
  MonitorListScreenState createState() => MonitorListScreenState();
}

class MonitorListScreenState extends State<MonitorListScreen> {
  late Future<List<Monitor>> futureMonitors;

  @override
  void initState() {
    super.initState();
    futureMonitors = ApiService.fetchMonitors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monitores do DPD'),
      ),
      body: FutureBuilder<List<Monitor>>(
        future: futureMonitors,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Monitor> monitors = snapshot.data!;
            return ListView.builder(
              itemCount: monitors.length,
              itemBuilder: (context, index) {
                Monitor monitor = monitors[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(monitor.avatarUrl),
                  ),
                  title: Text(monitor.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MonitorDetailScreen(monitor: monitor),
                      ),
                    );
                  },
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
