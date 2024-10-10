import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/monitor.dart';
import '../models/schedule.dart';

/// Tela que exibe os detalhes e horários de monitoria de um monitor específico.
///
/// A classe [MonitorDetailScreen] é um [StatefulWidget] que recebe um objeto
/// [Monitor] e exibe suas informações detalhadas, incluindo uma lista de seus
/// horários de monitoria. Utiliza a classe [ApiService] para buscar os horários
/// a partir da API.
class MonitorDetailScreen extends StatefulWidget {
  /// Objeto [Monitor] cujo detalhes serão exibidos.
  final Monitor monitor;

  /// Construtor padrão da classe [MonitorDetailScreen].
  ///
  /// Recebe um objeto [Monitor] obrigatório e uma chave opcional.
  const MonitorDetailScreen({super.key, required this.monitor});

  @override
  MonitorDetailScreenState createState() => MonitorDetailScreenState();
}

/// Estado da tela [MonitorDetailScreen].
///
/// Gerencia a busca dos horários de monitoria e a exibição dos detalhes.
class MonitorDetailScreenState extends State<MonitorDetailScreen> {
  /// Future que representa a busca assíncrona dos horários de monitoria.
  late Future<List<Schedule>> futureSchedules;

  /// Inicializa o estado da tela.
  ///
  /// Chama o metodo [ApiService.fetchSchedules] para buscar os horários do monitor.
  @override
  void initState() {
    super.initState();
    futureSchedules = ApiService.fetchSchedules(widget.monitor.id);
  }

  /// Constrói a interface da tela [MonitorDetailScreen].
  ///
  /// Utiliza um [Scaffold] com uma [AppBar] e um corpo que depende do estado
  /// da busca dos horários. Se os dados estiverem disponíveis, exibe uma
  /// [ListView] com os horários de monitoria. Se ocorrer um erro, exibe uma
  /// mensagem de erro. Enquanto os dados são carregados, exibe um
  /// [CircularProgressIndicator].
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
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
