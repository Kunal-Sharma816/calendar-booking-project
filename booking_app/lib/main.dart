import 'package:flutter/material.dart';
import 'screens/booking_list_screen.dart';

void main() {
  runApp(const BookingApp());
}

class BookingApp extends StatelessWidget {
  const BookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BookingListScreen(),  // <-- removed const here
    );
  }
}
