import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/create_booking_dialog.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({super.key});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  List<dynamic> bookings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    try {
      final data = await ApiService.getAllBookings();
      setState(() {
        bookings = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load bookings: $e')),
      );
    }
  }

  void _openCreateBookingDialog() {
    showDialog(
      context: context,
      builder: (context) => const CreateBookingDialog(),
    ).then((_) => fetchBookings());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookings')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return ListTile(
                  title: Text('User: ${booking['userId']}'),
                  subtitle: Text(
                      'From: ${booking['startTime']}\nTo: ${booking['endTime']}'),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateBookingDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
