// ignore_for_file: public_member_api_docs, sort_constructors_first
enum BookingStatusType { confirmed, pending, cancelled, completed }

class Booking {
  final String id;
  final String caregiverId;
  final String caregiverName;
  final double caregiverRating;
  final String caregiverImageUrl;

  final String clientId;
  final String clientName;
  final String clientImageUrl;
  final String clientAddress;

  final String careType;
  final DateTime date;
  final String timeStart;
  final String timeEnd;
  final String? notes;

  final BookingStatusType status;

  Booking({
    required this.id,
    required this.caregiverId,
    required this.caregiverName,
    required this.caregiverRating,
    required this.caregiverImageUrl,
    required this.clientId,
    required this.clientName,
    required this.clientImageUrl,
    required this.clientAddress,
    required this.careType,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    this.notes,
    required this.status,
  });
}
