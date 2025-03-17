// Servei de coumunicacion segures de l'aplicació.
// CreatedAt: 2025/02/14 dv. GPT[JIQ]

// Servei de comunicacions segures de l'aplicació.
// CreatedAt: 2025/02/14 dv. GPT[JIQ]
// Ampliat amb suport per a hores mundials: 2025/03/15 ds.

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ld_wbench3/core/ld_service.dart';
import 'package:ld_wbench3/views/world_time/world_time.dart';
import 'package:ld_wbench3/tools/debug.dart';

class LdNetworkService extends LdService {
  // 📝 ESTÀTICS -----------------------
  static LdNetworkService single = LdNetworkService();
  static const className = "LdNetworkService";

  // VARIABLES ------------------------
  // late final LdNetworkService _network;
  final String _worldTimeApiBase = 'http://worldtimeapi.org/api/timezone/';

  // 🛠️ CONSTRUCTORS ---------------------
  LdNetworkService() : super(pTag: className);

  Future<LdNetworkService> init() async {
    return this;
  }

  // NOVES FUNCIONS PER A CONSULTAR HORES MUNDIALS

  /// Obté l'hora d'una zona horària específica
  Future<WorldTime?> getTimeForZone(String timezone) async {
    try {
      final response = await http.get(Uri.parse('$_worldTimeApiBase$timezone'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return WorldTime.fromJson(data, timezone);
      } else {
        Debug.error(
          'Error en obtenir l\'hora per $timezone: ${response.statusCode}',
          null,
        );
        return null;
      }
    } catch (e) {
      Debug.error('Excepció en obtenir l\'hora per $timezone', e as Exception?);
      return null;
    }
  }

  /// Obté l'hora per a múltiples zones horàries simultàniament
  Future<List<WorldTime>> getTimeForMultipleZones(
    List<String> timezones,
  ) async {
    List<WorldTime> results = [];

    // Executem totes les peticions en paral·lel
    final futures = timezones.map((timezone) => getTimeForZone(timezone));
    final responses = await Future.wait(futures);

    // Filtrem els resultats nuls
    for (var response in responses) {
      if (response != null) {
        results.add(response);
      }
    }

    return results;
  }

  /// Verifica si el servei està disponible
  Future<bool> isWorldTimeServiceAvailable() async {
    try {
      final response = await http.get(Uri.parse(_worldTimeApiBase));
      return response.statusCode == 200;
    } catch (e) {
      Debug.error(
        'Error verificant disponibilitat del servei',
        e as Exception?,
      );
      return false;
    }
  }
}
