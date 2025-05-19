enum BookingStatusType {
  confirmed,
  pending,
  cancelled,
  completed,
}

class Booking {
  final String id;
  final String caregiverId;
  final String caregiverName;
  final double caregiverRating;
  final String caregiverImageUrl;
  final DateTime date;
  final String timeStart;
  final String timeEnd;
  final String location;
  final BookingStatusType status;

  Booking({
    required this.id,
    required this.caregiverId,
    required this.caregiverName,
    required this.caregiverRating,
    required this.caregiverImageUrl,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.location,
    required this.status,
  });
}