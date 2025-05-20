// ignore_for_file: public_member_api_docs, sort_constructors_first
class Booking {
  final String? id;
  final String caregiverId;
  final String seekerId;
  final DateTime date;
  final String time;
  final String serviceType;
  final String notes;
  final String status;

  Booking({
    this.id,
    required this.caregiverId,
    required this.seekerId,
    required this.date,
    required this.time,
    required this.serviceType,
    required this.notes,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'caregiverId': caregiverId,
      'seekerId': seekerId,
      'date': date.toIso8601String(),
      'time': time,
      'serviceType': serviceType,
      'notes': notes,
      'status': status,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] ?? '',
      caregiverId: map['caregiverId'],
      seekerId: map['seekerId'],
      date: DateTime.parse(map['date']),
      time: map['time'],
      serviceType: map['serviceType'],
      notes: map['notes'],
      status: map['status'],
    );
  }
}
