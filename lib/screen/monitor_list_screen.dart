// lib/screens/monitor_list_screen.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/monitor.dart';
import '../services/api_service.dart';
import '../util/logger.dart';
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
    futureMonitors = ApiService.fetchMonitors(results: 20); // Obter 20 monitores
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitores do DPD'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/test-image'); // Opcional: para testes
        },
        tooltip: 'Testar Imagem',
        child: const Icon(Icons.image),
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
                  leading: CachedNetworkImage(
                    imageUrl: monitor.avatarUrl,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                      radius: 20,
                    ),
                    placeholder: (context, url) => const CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 20,
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) {
                      logger.severe('Erro ao carregar imagem: $error');
                      return const CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 20,
                        child: Icon(Icons.error),
                      );
                    },
                  ),
                  title: Text(monitor.name),
                  subtitle: Text(monitor.email),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MonitorDetailScreen(monitor: monitor),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            logger.severe('Erro ao carregar monitores: ${snapshot.error}');
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
