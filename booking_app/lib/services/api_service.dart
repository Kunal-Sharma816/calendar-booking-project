import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/booking.dart';

class ApiService {
  static const baseUrl = 'http://localhost:3000';

  static Future<List<Booking>> fetchBookings() async {
    final res = await http.get(Uri.parse('$baseUrl/bookings'));
    if (res.statusCode == 200) {
      final List jsonList = json.decode(res.body);
      return jsonList.map((e) => Booking.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  static Future<Booking> fetchBookingId(String bookingId) async {
    try {
      final res = await http.get(Uri.parse('$baseUrl/bookings/$bookingId'));
      final responseBody = json.decode(res.body);

      if (res.statusCode == 200) {
        return Booking.fromJson(responseBody);
      } else {
        throw Exception(responseBody['message'] ?? 'Booking not found');
      }
    } catch (e) {
      throw Exception('Failed to fetch booking: $e');
    }
  }



  static Future<Map<String, dynamic>> createBooking(Booking booking) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/bookings'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(booking.toJson()),
      );

      final responseBody = json.decode(res.body);

      if (res.statusCode == 201) {
        return {
          'success': true,
          'bookingId': responseBody['_id'],
        };
      } else {
        return {
          'success': false,
          'error': responseBody['message'] ?? 'Failed to create booking',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
      };
    }
  }

}
