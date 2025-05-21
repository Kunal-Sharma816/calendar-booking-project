import 'package:flutter/material.dart';

class BookingTile extends StatelessWidget {
  final Map booking;
  BookingTile({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        leading: Icon(Icons.calendar_today),
        title: Text('User: ${booking['userId']}'),
        subtitle: Text(
          'From: ${booking['startTime']}\nTo: ${booking['endTime']}',
        ),
      ),
    );
  }
}
