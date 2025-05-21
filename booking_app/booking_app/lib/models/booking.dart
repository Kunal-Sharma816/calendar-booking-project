class Booking {
  final String userId;
  final DateTime startTime;
  final DateTime endTime;
  final String meetingRoomId;

  Booking({
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.meetingRoomId,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      userId: json['userId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      meetingRoomId: json['meetingRoomId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'startTime': startTime.toUtc().toIso8601String(),
      'endTime': endTime.toUtc().toIso8601String(),
      'meetingRoomId': meetingRoomId,
    };
  }
}
