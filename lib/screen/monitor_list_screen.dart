import 'package:flutter/material.dart';
import '../models/monitor.dart';
import '../services/api_service.dart';
import 'monitor_detail_screen.dart';

/// Tela que exibe a lista de monitores do DPD.
///
/// A classe [MonitorListScreen] é um [StatefulWidget] que gerencia o estado
/// da lista de monitores. Ela busca os dados dos monitores através da
/// classe [ApiService] e exibe-os em uma lista interativa. Ao selecionar
/// um monitor, navega para a tela [MonitorDetailScreen] para exibir
/// detalhes adicionais.
class MonitorListScreen extends StatefulWidget {
  /// Construtor padrão da classe [MonitorListScreen].
  ///
  /// Recebe uma chave opcional para identificação do widget.
  const MonitorListScreen({super.key});

  @override
  MonitorListScreenState createState() => MonitorListScreenState();
}

/// Estado da tela [MonitorListScreen].
///
/// Gerencia a busca dos dados dos monitores e a exibição da lista.
class MonitorListScreenState extends State<MonitorListScreen> {
  /// Future que representa a busca assíncrona da lista de monitores.
  late Future<List<Monitor>> futureMonitors;

  /// Inicializa o estado da tela.
  ///
  /// Chama o metodo [ApiService.fetchMonitors] para buscar a lista de monitores.
  @override
  void initState() {
    super.initState();
    futureMonitors = ApiService.fetchMonitors();
  }

  /// Constrói a interface da tela [MonitorListScreen].
  ///
  /// Utiliza um [Scaffold] com uma [AppBar] e um corpo que depende do estado
  /// da busca dos monitores. Se os dados estiverem disponíveis, exibe uma
  /// [ListView] com os monitores. Se ocorrer um erro, exibe uma mensagem de
  /// erro. Enquanto os dados são carregados, exibe um [CircularProgressIndicator].
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitores do DPD'),
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
                    // Navega para a tela de detalhes do monitor selecionado
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
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
