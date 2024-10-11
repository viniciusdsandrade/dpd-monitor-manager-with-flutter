import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/monitor.dart';
import '../models/schedule.dart';

/// Serviço para interagir com a Random User API e gerenciar o cache de dados.
class ApiService {
  /// URL base da Random User API.
  static const String baseUrl = 'https://randomuser.me/api';

  static Future<List<Monitor>> fetchMonitors({int results = 10}) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/?results=$results'));

      if (response.statusCode == 200) {
        // Armazena os dados no cache
        await cacheMonitors(response.body);

        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> users = jsonResponse['results'];

        List<Monitor> monitors =
            users.map((user) => Monitor.fromJson(user)).toList();

        // Adicione este print para verificar as URLs
        for (var monitor in monitors) {
          print('Monitor: ${monitor.name}, Avatar URL: ${monitor.avatarUrl}');
        }

        return monitors;
      } else {
        throw Exception('Falha ao carregar monitores');
      }
    } catch (e) {
      // Se ocorrer um erro, tenta recuperar do cache
      String? cachedData = await getCachedMonitors();
      if (cachedData != null) {
        Map<String, dynamic> jsonResponse = json.decode(cachedData);
        List<dynamic> users = jsonResponse['results'];

        List<Monitor> monitors =
            users.map((user) => Monitor.fromJson(user)).toList();

        // Adicione este print para verificar as URLs do cache
        for (var monitor in monitors) {
          print(
              'Monitor (Cache): ${monitor.name}, Avatar URL: ${monitor.avatarUrl}');
        }

        return monitors;
      } else {
        rethrow; // Se não houver cache, rethrow o erro
      }
    }
  }

  /// Gera horários de monitoria aleatórios para um monitor.
  static Future<List<Schedule>> fetchSchedules(String monitorId) async {
    // Dias da semana disponíveis
    List<String> daysOfWeek = [
      'Segunda-feira',
      'Terça-feira',
      'Quarta-feira',
      'Quinta-feira',
      'Sexta-feira'
    ];

    // Gerar de 1 a 3 horários aleatórios
    int numberOfSchedules = Random().nextInt(3) + 1;
    List<Schedule> schedules = [];

    for (int i = 0; i < numberOfSchedules; i++) {
      String day = daysOfWeek[Random().nextInt(daysOfWeek.length)];
      String startTime = '${Random().nextInt(8) + 8}:00'; // Entre 8:00 e 15:00
      String endTime =
          '${int.parse(startTime.split(':')[0]) + 2}:00'; // Duração de 2 horas

      schedules.add(Schedule(
        id: i,
        monitorId: monitorId,
        dayOfWeek: day,
        startTime: startTime,
        endTime: endTime,
      ));
    }

    return Future.value(schedules);
  }

  // Função para armazenar monitores em cache
  static Future<void> cacheMonitors(String monitorsJson) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('monitors', monitorsJson);
  }

  // Função para recuperar monitores do cache
  static Future<String?> getCachedMonitors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('monitors');
  }
}
