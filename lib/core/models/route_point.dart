class RoutePointResource {
  final double latitude;
  final double longitude;
  final String eventDate;
  final String eventType;
  final String actorName;

  RoutePointResource({
    required this.latitude,
    required this.longitude,
    required this.eventDate,
    required this.eventType,
    required this.actorName,
  });

  factory RoutePointResource.fromJson(Map<String, dynamic> json) {
    return RoutePointResource(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      eventDate: json['eventDate'] ?? '',
      eventType: json['eventType'] ?? '',
      actorName: json['actorName'] ?? '',
    );
  }
}
