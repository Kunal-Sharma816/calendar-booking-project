import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://192.168.1.100:3000/api/bookings';


  static Future<List<dynamic>> getAllBookings() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  static Future<void> createBooking(String userId, String startTime, String endTime) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userId': userId,
        'startTime': startTime,
        'endTime': endTime,
      }),
    );

    if (response.statusCode != 201) {
      final body = json.decode(response.body);
      throw Exception(body['message'] ?? 'Failed to create booking');
    }
  }
}
