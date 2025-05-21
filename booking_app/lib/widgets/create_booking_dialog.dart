import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CreateBookingDialog extends StatefulWidget {
  const CreateBookingDialog({super.key});

  @override
  State<CreateBookingDialog> createState() => _CreateBookingDialogState();
}

class _CreateBookingDialogState extends State<CreateBookingDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  Future<void> createBooking() async {
    if (!_formKey.currentState!.validate()) return;

    final userId = userIdController.text.trim();
    final startTime = startTimeController.text.trim();
    final endTime = endTimeController.text.trim();

    try {
      await ApiService.createBooking(userId, startTime, endTime);
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Booking'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: userIdController,
                decoration: const InputDecoration(labelText: 'User ID'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter user ID' : null,
              ),
              TextFormField(
                controller: startTimeController,
                decoration:
                    const InputDecoration(labelText: 'Start Time (ISO8601)'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter start time' : null,
              ),
              TextFormField(
                controller: endTimeController,
                decoration:
                    const InputDecoration(labelText: 'End Time (ISO8601)'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter end time' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel')),
        ElevatedButton(onPressed: createBooking, child: const Text('Book')),
      ],
    );
  }
}
