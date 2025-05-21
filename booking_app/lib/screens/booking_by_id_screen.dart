import 'package:flutter/material.dart';
import '../services/api_service.dart';

class BookingByIdScreen extends StatefulWidget {
  @override
  _BookingByIdScreenState createState() => _BookingByIdScreenState();
}

class _BookingByIdScreenState extends State<BookingByIdScreen> {
  final controller = TextEditingController();
  Map<String, dynamic>? booking;
  String? error;

  void getBooking() async {
    final result = await ApiService.getBookingById(controller.text.trim());
    setState(() {
      booking = result;
      error = result == null ? 'Booking not found' : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Booking by ID")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: 'Enter Booking ID'),
            ),
            ElevatedButton(onPressed: getBooking, child: Text("Fetch Booking")),
            SizedBox(height: 20),
            if (booking != null) ...[
              Text("User: ${booking!['userId']}"),
              Text("Start: ${booking!['startTime']}"),
              Text("End: ${booking!['endTime']}"),
            ] else if (error != null)
              Text(error!, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
