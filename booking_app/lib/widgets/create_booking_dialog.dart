import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CreateBookingDialog extends StatefulWidget {
  @override
  _CreateBookingDialogState createState() => _CreateBookingDialogState();
}

class _CreateBookingDialogState extends State<CreateBookingDialog> {
  final userIdController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  String? error;

  void submit() async {
    final userId = userIdController.text.trim();
    final startStr = startTimeController.text.trim();
    final endStr = endTimeController.text.trim();

    if (userId.isEmpty || startStr.isEmpty || endStr.isEmpty) {
      setState(() {
        error = 'All fields are required.';
      });
      return;
    }

    DateTime? start;
    DateTime? end;

    try {
      start = DateTime.parse(startStr);
      end = DateTime.parse(endStr);
    } catch (e) {
      setState(() {
        error = 'Invalid date/time format. Use ISO format like 2025-05-21T07:00:00Z';
      });
      return;
    }

    try {
      await ApiService.createBooking(userId, start, end);
      Navigator.pop(context, true);
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Booking'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: userIdController,
              decoration: InputDecoration(labelText: 'User ID'),
            ),
            TextField(
              controller: startTimeController,
              decoration: InputDecoration(labelText: 'Start Time (UTC ISO)'),
            ),
            TextField(
              controller: endTimeController,
              decoration: InputDecoration(labelText: 'End Time (UTC ISO)'),
            ),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  error!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: submit,
          child: Text("Book"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
      ],
    );
  }
}
