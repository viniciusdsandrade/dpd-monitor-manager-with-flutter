import 'dart:convert';
import 'package:dpd_monitor_manager_with_flutter/models/schedule.dart';
import 'package:http/http.dart' as http;

import '../models/monitor.dart';

class ApiService {
  static const String baseUrl = 'https://sua-api.com'; // Substitua pela URL da sua API

  static Future<List<Monitor>> fetchMonitors() async {
    final response = await http.get(Uri.parse('$baseUrl/monitors'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((monitor) => Monitor.fromJson(monitor)).toList();
    } else {
      throw Exception('Falha ao carregar monitores');
    }
  }

  static Future<List<Schedule>> fetchSchedules(int monitorId) async {
    final response =
    await http.get(Uri.parse('$baseUrl/monitors/$monitorId/schedules'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((schedule) => Schedule.fromJson(schedule)).toList();
    } else {
      throw Exception('Falha ao carregar horários');
    }
  }
}
