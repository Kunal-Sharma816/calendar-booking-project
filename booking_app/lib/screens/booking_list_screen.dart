import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/booking_tile.dart';
import '../widgets/create_booking_dialog.dart';
import 'booking_by_id_screen.dart';

class BookingListScreen extends StatefulWidget {
  @override
  _BookingListScreenState createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  List bookings = [];

  void fetchBookings() async {
    final data = await ApiService.getAllBookings();
    setState(() {
      bookings = data;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Bookings'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => BookingByIdScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final result = await showDialog(
                context: context,
                builder: (_) => CreateBookingDialog(),
              );
              if (result == true) fetchBookings(); // Refresh if booking is added
            },
          ),
        ],
      ),
      body: bookings.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) => BookingTile(booking: bookings[index]),
            ),
    );
  }
}
