import 'dart:convert';
import 'package:dpd_monitor_manager_with_flutter/models/schedule.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/monitor.dart';

/// Serviço para interagir com a API do DPD e gerenciar o cache de dados.
///
/// A classe [ApiService] fornece métodos estáticos para buscar monitores e seus
/// horários de monitoria a partir de uma API externa. Além disso, implementa
/// funcionalidades de cache utilizando o pacote [shared_preferences] para armazenar
/// dados localmente, melhorando a performance e a resiliência do aplicativo em caso
/// de falhas na conexão com a API.
class ApiService {
  /// URL base da API.
  ///
  /// Deve ser substituída pela URL real da sua API.
  static const String baseUrl =
      'https://sua-api.com'; // Substitua pela URL da sua API

  /// Busca a lista de monitores a partir da API.
  ///
  /// Este metodo tenta obter os dados dos monitores fazendo uma requisição HTTP
  /// GET para a rota `/monitors`. Se a requisição for bem-sucedida (código de
  /// status 200), os dados serão armazenados no cache local e retornados como uma
  /// lista de objetos [Monitor]. Caso contrário, será lançada uma exceção.
  ///
  /// Em caso de falha na requisição (por exemplo, falta de conexão com a internet),
  /// o metodo tentará recuperar os dados dos monitores a partir do cache local.
  ///
  /// ```dart
  /// try {
  ///   List<Monitor> monitores = await ApiService.fetchMonitors();
  /// } catch (e) {
  ///   // Tratar o erro
  /// }
  /// ```
  ///
  /// Retorna uma [Future] que resolve para uma lista de objetos [Monitor].
  ///
  /// Lança uma [Exception] se não for possível obter os dados dos monitores.
  static Future<List<Monitor>> fetchMonitors() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/monitors'));

      if (response.statusCode == 200) {
        // Armazena os dados no cache
        await cacheMonitors(response.body);

        List jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((monitor) => Monitor.fromJson(monitor))
            .toList();
      } else {
        throw Exception('Falha ao carregar monitores');
      }
    } catch (e) {
      // Se ocorrer um erro, tenta recuperar do cache
      String? cachedData = await getCachedMonitors();
      if (cachedData != null) {
        List jsonResponse = json.decode(cachedData);
        return jsonResponse
            .map((monitor) => Monitor.fromJson(monitor))
            .toList();
      } else {
        rethrow; // Se não houver cache, rethrow o erro
      }
    }
  }

  /// Busca os horários de monitoria para um monitor específico a partir da API.
  ///
  /// Este metodo realiza uma requisição HTTP GET para a rota `/monitors/{monitorId}/schedules`
  /// para obter os horários de monitoria do monitor identificado por [monitorId].
  ///
  /// ```dart
  /// try {
  ///   List<Schedule> horarios = await ApiService.fetchSchedules(1);
  /// } catch (e) {
  ///   // Tratar o erro
  /// }
  /// ```
  ///
  /// **Parâmetros:**
  /// - [monitorId] (`int`): O identificador único do monitor cujo horário será buscado.
  ///
  /// **Retorna:**
  /// - Uma [Future] que resolve para uma lista de objetos [Schedule].
  ///
  /// **Exceções:**
  /// - Lança uma [Exception] se a requisição falhar ou se o servidor retornar um código de status
  ///   diferente de 200.
  static Future<List<Schedule>> fetchSchedules(int monitorId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/monitors/$monitorId/schedules'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((schedule) => Schedule.fromJson(schedule))
          .toList();
    } else {
      throw Exception('Falha ao carregar horários');
    }
  }

  /// Armazena os dados dos monitores no cache local.
  ///
  /// Este metodo utiliza o pacote [shared_preferences] para salvar os dados dos monitores
  /// em formato JSON no armazenamento local do dispositivo. Isso permite que os dados
  /// sejam recuperados posteriormente sem a necessidade de uma nova requisição à API.
  ///
  /// ```dart
  /// await ApiService.cacheMonitors(jsonData);
  /// ```
  ///
  /// **Parâmetros:**
  /// - [monitorsJson] (`String`): A string JSON contendo os dados dos monitores.
  ///
  /// **Retorna:**
  /// - Uma [Future] que resolve para `void` após os dados serem armazenados.
  static Future<void> cacheMonitors(String monitorsJson) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('monitors', monitorsJson);
  }

  /// Recupera os dados dos monitores a partir do cache local.
  ///
  /// Este metodo utiliza o pacote [shared_preferences] para obter os dados dos monitores
  /// armazenados localmente em formato JSON. Se os dados estiverem disponíveis, retorna
  /// a string JSON correspondente; caso contrário, retorna `null`.
  ///
  /// ```dart
  /// String? cachedMonitors = await ApiService.getCachedMonitors();
  /// if (cachedMonitors != null) {
  ///   // Processar os dados em cache
  /// }
  /// ```
  ///
  /// **Retorna:**
  /// - Uma [Future] que resolve para uma string JSON contendo os dados dos monitores
  ///   ou `null` se nenhum dado estiver armazenado no cache.
  static Future<String?> getCachedMonitors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('monitors');
  }
}
