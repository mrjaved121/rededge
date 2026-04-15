import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'package:suprapp/app/core/network/api_constants.dart';

class RideWebSocketService {
  WebSocketChannel? _channel;

  void connectToRide({
    required int orderId,
    required Function(String) onStatusUpdate,
    required Function(double, double) onDriverLocation,
  }) {
    disconnect();

    // Use the correct WebSocket URL from API constants
    final wsUrl = '${ApiConstants.baseUrl.replaceFirst('http', 'ws')}/ws/ride/$orderId';
    _channel = WebSocketChannel.connect(Uri.parse(wsUrl));

    _channel!.stream.listen((message) {
      final data = json.decode(message);

      if (data['type'] == 'status_update') {
        onStatusUpdate(data['status']);
      } else if (data['type'] == 'driver_location') {
        onDriverLocation(
          data['latitude'].toDouble(),
          data['longitude'].toDouble(),
        );
      }
    });
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
  }
}