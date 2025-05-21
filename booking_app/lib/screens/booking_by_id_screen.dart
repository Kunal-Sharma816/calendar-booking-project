import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/booking.dart';  // import Booking model

class BookingByIdScreen extends StatefulWidget {
  @override
  _BookingByIdScreenState createState() => _BookingByIdScreenState();
}

class _BookingByIdScreenState extends State<BookingByIdScreen> {
  final controller = TextEditingController();
  Booking? booking;  // use Booking model type
  String? error;
  bool isLoading = false;

  void getBooking() async {
    final id = controller.text.trim();
    if (id.isEmpty) {
      setState(() {
        error = 'Please enter a booking ID';
        booking = null;
      });
      return;
    }

    setState(() {
      isLoading = true;
      error = null;
      booking = null;
    });

    try {
      final result = await ApiService.getBookingById(id);
      setState(() {
        booking = result;
        error = result == null ? 'Booking not found' : null;
      });
    } catch (e) {
      setState(() {
        error = 'Failed to fetch booking: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
              onChanged: (value) {
                setState(() {
                  booking = null;
                  error = null;
                });
              },
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: isLoading ? null : getBooking,
              child: isLoading
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text("Fetch Booking"),
            ),
            SizedBox(height: 24),
            if (booking != null) ...[
              Text("User: ${booking!.userId}"),
              SizedBox(height: 8),
              Text("Start: ${booking!.startTime.toIso8601String()}"),
              SizedBox(height: 8),
              Text("End: ${booking!.endTime.toIso8601String()}"),
            ] else if (error != null)
              Text(error!, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
