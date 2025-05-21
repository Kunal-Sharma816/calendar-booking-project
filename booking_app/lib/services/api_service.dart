import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/booking.dart';

class ApiService {
  // Update with your actual backend endpoint
  static const String baseUrl = 'http://localhost:3000/api/bookings';

  /// Get all bookings
  static Future<List<Booking>> getAllBookings() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Booking.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception('Error fetching bookings: $e');
    }
  }

  /// Get booking by ID
  static Future<Booking?> getBookingById(String bookingId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$bookingId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Booking.fromJson(data);
    } else {
      return null;
    }
    } catch (e) {
      throw Exception('Error fetching booking by ID: $e');
    }
  }

  /// Create a new booking
  static Future<void> createBooking(String userId, DateTime startTime, DateTime endTime) async {
  final response = await http.post(
    Uri.parse(baseUrl),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'userId': userId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    }),
  );

  if (response.statusCode != 201) {
    final body = json.decode(response.body);
    throw Exception(body['message'] ?? 'Failed to create booking');
  }
}
}
