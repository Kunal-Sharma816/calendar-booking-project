import 'package:flutter/material.dart';
import '../models/booking.dart';
import 'package:intl/intl.dart';

class BookingDetailsDialog extends StatelessWidget {
  final Booking booking;

  const BookingDetailsDialog({required this.booking, super.key});

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat.yMd().add_jm();
    final now = DateTime.now();
    final duration = booking.endTime.difference(booking.startTime);
    final timeToStart = booking.startTime.difference(now);

    // Format duration
    String durationText;
    if (duration.inHours > 0) {
      durationText = "${duration.inHours}h ${duration.inMinutes % 60}m";
    } else {
      durationText = "${duration.inMinutes}m";
    }

    // Format time to start
    String timeToStartText;
    if (timeToStart.isNegative) {
      timeToStartText = "Started ${-timeToStart.inMinutes} minutes ago";
    } else if (timeToStart.inMinutes < 60) {
      timeToStartText = "Starts in ${timeToStart.inMinutes} minutes";
    } else {
      timeToStartText = "Starts in ${timeToStart.inHours}h ${timeToStart.inMinutes % 60}m";
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      backgroundColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and title
            Row(
              children: [
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
                Expanded(
                  child: Text(
                    "Booking Details",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // User ID
            Text(
              "User: ${booking.userId}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            // Time Range
            Text(
              "Time: ${fmt.format(booking.startTime)} → ${fmt.format(booking.endTime)}",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            // Duration
            Text(
              "Duration: $durationText",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            // Time to Start
            Text(
              timeToStartText,
              style: TextStyle(
                fontSize: 16,
                color: timeToStart.isNegative ? Colors.red.shade700 : Colors.green.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            // Close Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  backgroundColor: Colors.teal.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Close",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}