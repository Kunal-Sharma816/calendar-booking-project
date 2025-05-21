import 'package:flutter/material.dart';
import '../models/booking.dart';
import 'package:intl/intl.dart';
import 'booking_details_dialog.dart';

class BookingTile extends StatelessWidget {
  final Booking booking;

  const BookingTile({required this.booking, super.key});

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat.yMd().add_jm();
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => BookingDetailsDialog(booking: booking),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(4, 4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            // Leading icon with a circular avatar
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.teal.shade100,
              child: const Icon(
                Icons.meeting_room,
                color: Colors.teal,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            // Main content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User: ${booking.userId}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${fmt.format(booking.startTime)} → ${fmt.format(booking.endTime)}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            // Status chip
            Chip(
              label: Text(
                "Active",
                style: TextStyle(
                  color: Colors.teal.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: Colors.teal.shade50,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
          ],
        ),
      ),
    );
  }
}