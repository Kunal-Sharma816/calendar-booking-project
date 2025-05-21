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
    final start = startTimeController.text.trim();
    final end = endTimeController.text.trim();

    final result = await ApiService.createBooking(userId, start, end);
    if (result == null) {
      setState(() => error = 'Booking conflict or invalid input.');
    } else {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Booking'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: userIdController, decoration: InputDecoration(labelText: 'User ID')),
            TextField(controller: startTimeController, decoration: InputDecoration(labelText: 'Start Time (UTC ISO)')),
            TextField(controller: endTimeController, decoration: InputDecoration(labelText: 'End Time (UTC ISO)')),
            if (error != null) Text(error!, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
      actions: [
        ElevatedButton(onPressed: submit, child: Text("Book")),
        TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
      ],
    );
  }
}
