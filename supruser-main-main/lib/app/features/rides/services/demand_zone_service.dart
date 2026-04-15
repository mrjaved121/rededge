import 'package:suprapp/app/core/network/http_service.dart';
import 'package:suprapp/app/core/network/api_constants.dart';

class DemandZoneService {
  final _http = HttpService.instance;

  // Get demand zones (high and low demand areas)
  Future<Map<String, dynamic>> getDemandZones() async {
    try {
      final response = await _http.get(ApiConstants.demandZones);
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw 'Failed to fetch demand zones: $e';
    }
  }
}