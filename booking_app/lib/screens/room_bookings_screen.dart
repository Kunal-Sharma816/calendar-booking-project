import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../widgets/booking_tile.dart';
import '../widgets/create_booking_dialog.dart';
import '../widgets/booking_details_dialog.dart';

class RoomBookingsScreen extends StatelessWidget {
  final String roomName;
  final List<Booking> bookings;

  const RoomBookingsScreen({required this.roomName, required this.bookings, super.key});

  @override
  Widget build(BuildContext context) {
    // Sort bookings by startTime
    final sortedBookings = List<Booking>.from(bookings)
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          roomName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.cyan],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<bool>(
            context: context,
            builder: (_) => CreateBookingDialog(roomName: roomName),
          );
          if (result == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Booking created"),
                backgroundColor: Colors.teal,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
              ),
            );
          } else if (result == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Failed to create booking"),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
              ),
            );
          }
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, size: 28, color: Colors.white),
        elevation: 6,
        hoverElevation: 12,
        tooltip: "Create Booking",
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: sortedBookings.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.event_busy,
                size: 64,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                "No bookings for $roomName",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Tap the + button to create a booking",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.only(top: 80, bottom: 80),
          itemCount: sortedBookings.length,
          itemBuilder: (_, i) => AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: BookingTile(booking: sortedBookings[i]),
          ),
        ),
      ),
    );
  }
}